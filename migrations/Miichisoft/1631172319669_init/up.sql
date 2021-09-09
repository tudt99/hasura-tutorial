SET check_function_bodies = false;
CREATE TABLE public.employees (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    manager_id uuid DEFAULT public.gen_random_uuid()
);
CREATE TABLE public.payroll (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    salary integer NOT NULL,
    employee_id uuid DEFAULT public.gen_random_uuid() NOT NULL
);
CREATE TABLE public.todos (
    id integer NOT NULL,
    name text NOT NULL,
    user_id integer
);
CREATE SEQUENCE public.todos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.todos_id_seq OWNED BY public.todos.id;
CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL
);
CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
ALTER TABLE ONLY public.todos ALTER COLUMN id SET DEFAULT nextval('public.todos_id_seq'::regclass);
ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.payroll
    ADD CONSTRAINT payroll_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.todos
    ADD CONSTRAINT todos_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.employees(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.payroll
    ADD CONSTRAINT payroll_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.todos
    ADD CONSTRAINT todos_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;

> Тест

# Описание

Здесь мы хотим посмотреть на возможность компиляции ядра Linux (минимальной
конфигурации `tinyconfig`) на двух виртуальных машинах с разными 
характеристиками. Но для этого нужно рассказать про утилиту `vagrant`,
конфигуратор виртуальных машин.

## Vagrant

Vagrant[^1] (с англ. — «бродяга») — свободное и открытое программное
обеспечение для создания и конфигурирования виртуальной среды разработки.
Является обёрткой для программного обеспечения виртуализации, например
VirtualBox, и средств управления конфигурациями, таких как Chef, Salt и 
Puppet.

Данная утилита полезна тем, что позволяет, используя шаблоны виртуальных
машин, запускать их. Для описания стэка требуется один т.н. Vagrantfile. 
Она может работать совместно с qemu, VirtualBox, VMWare и пр. 

О vagrant стоит знать потому, что в какой момент, эксперементируя с 
виртуальными машинами, надоест каждый раз их устанавливать в условном VMWare.

## Distcc

distcc[^2] (от англ. distributed C/C++/ObjC compiler) — инструмент, 
позволяющий компилировать исходные коды при помощи 
компиляторов C/C++/ObjC на удалённых машинах, что ускоряет процесс компиляции.

Важно понимать, что это своего рода фронтенд для компиляторов, 
сам по себе он не компилирует код.

# Запуск

Для начала запустим стенд командой `vagrant up`. На моем ноутбуке это занимает 
примерно __ секунд.

Далее необходимо подключиться к главной машине и распаковать исходники ядра[^3]:

```
vagrant ssh master
tar xvf linux-6.13.tar.gz
cd linux-6.13
```

Создаем файл минимальной конфигурации 
(с остальными вариантам можно ознакомиться командой `make help | less`):

```
make tinyconfig
```
  


[^1]: Википедия [Vagrant](https://ru.wikipedia.org/wiki/Vagrant).
[^2]: Википедия [distcc](https://ru.wikipedia.org/wiki/Distcc).
[^3]: Исходный код ядра можно найти [здесь](https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.13.tar.gz).

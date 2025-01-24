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

[^1]: Википедия [Vagrant](https://ru.wikipedia.org/wiki/Vagrant).
[^2]: Википедия [distcc](https://ru.wikipedia.org/wiki/Distcc).
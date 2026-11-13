Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533510;
	b=YHmxBlOm4RR7daPBdjsK1cNkeVxUAW56OkbzXsLale16mtDHcHmfmGBdNrw5+pjXJLfe
	 9e8uTJJ1wWhyyyYJNmcIfW5hugF7UeeUeQ1GlX0GbtilCFujZ7ogJtCBCLsZcaqQ/Pl2c
	 JBqOk7IQa1FGzswsIErfp90DJOtHHONg1lCNlrM2xPkOQ7xWASaC5eIwIq4m0DyW9mStK
	 i8cRpqv5yc7+bQT8cbvY7vNl0ZKJVIfnFisOLs7fjS0DAjrL0Vhm8EL9CJPL6hTcXzZUu
	 KWHNd2v1mA9z6sF8ZiUJ9IMjH77wzDWxCfRJWdZQ1hMog0sh2bRGSEuY67dXBRY63Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533510;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q1uGL5QIdEZ9yhBZESg1eFFZL7UKWk/Jwtk4XOOUnQY=;
	b=YlInrcuSdEiZTvyxqE5a+sfpQOG+T+IpSFs+K1nW4VfkVvhcxNTBZ3liqVyreg5DwQlv
	 +/R+hDqiAUC+BohuPrQh+UFZVXl7SJWS60y3ubeGSq7FOiW41gzprDWsu2sG8Rb3uD9pC
	 HCGZc+XN+Zt2DqXEJ55JcbmD0o1n8uU2mdCWU/UUYnaR7LivGXgv/OjjLqGy7tzWF780D
	 OwkoJsqLr8K95VgLaFR2dNO+eYl2s3qli2NDQA6KkT3b4brN4syiKj7//Wwr93PQ6BlnY
	 leNrlnUv2VRJpGZNwSCvJZq4/e9Gs3YafTu6m6NHyWQ1EOczI3D4rBhxiPsMPhgfSaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qoZlmEkc;
	arc=none smtp.remote-ip=91.218.175.8
Received: from mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC1606A31C
	for <rcu@vger.kernel.org>; Fri, 13 Nov 2026 01:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23BC1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qoZlmEkc
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=F6CiNbOdEvn4C0iIHHrqwJzePSNILKWGTxTWkXjJL8s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794533507; v=1; x=1795138307;
 b=qoZlmEkcCNt+u7e80NNLZFGtp+Z653bVFgOCboO7qfi8Falv48oIkJXolAb7jDt2C+7Izday
 S5w7c5rsDj40Kooek9FHWj+ffMeXksBm145k7cukFPy5CE8O9b7GK4jZmXlpqglYjtljoOJxyt9
 P9oU9MKOVg0pYimLUyfuXgn8=
X-Envelope-To: rcu@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 1b88fe80a2c3683f;
	Fri, 13 Nov 2026 01:31:46 +0000
X-Mizu-Trace-ID: 1b88fe80a2c3683f
X-Migadu-Flow: FLOW_OUT
From: xiongwei.song@linux.dev
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	dzm91@hust.edu.cn
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	paulmck@kernel.org,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiongwei Song <xiongwei.song@linux.dev>
Subject: [PATCH 2/2] docs/zh_CN: Add RCU/whatisRCU.rst Chinese translation
Date: Fri, 13 Nov 2026 09:30:23 +0800
Message-ID: <20261113013054.5662-3-xiongwei.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261113013054.5662-1-xiongwei.song@linux.dev>
References: <20261113013054.5662-1-xiongwei.song@linux.dev>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Xiongwei Song <xiongwei.song@linux.dev>

Translate .../RCU/whatisRCU.rst into Chinese.

Update the translation through commit b3eb16109ae1
("doc: Update stallwarn.rst based on RCU Tasks Trace as SRCU")

Signed-off-by: Xiongwei Song <xiongwei.song@linux.dev>
---
 .../translations/zh_CN/RCU/index.rst          |    3 +-
 .../translations/zh_CN/RCU/whatisRCU.rst      | 1220 +++++++++++++++++
 2 files changed, 1222 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/RCU/whatisRCU.rst

diff --git a/Documentation/translations/zh_CN/RCU/index.rst b/Documentation/translations/zh_CN/RCU/index.rst
index 6db03061fd87..83ba140b7489 100644
--- a/Documentation/translations/zh_CN/RCU/index.rst
+++ b/Documentation/translations/zh_CN/RCU/index.rst
@@ -19,6 +19,8 @@ RCU Handbook
 .. toctree::
    :maxdepth: 2
 
+   whatisRCU
+
 TODOLIST:
 
 * checklist
@@ -26,7 +28,6 @@ TODOLIST:
 * lockdep-splat
 * rcubarrier
 * rcu_dereference
-* whatisRCU
 * rcu
 * rculist_nulls
 * rcuref
diff --git a/Documentation/translations/zh_CN/RCU/whatisRCU.rst b/Documentation/translations/zh_CN/RCU/whatisRCU.rst
new file mode 100644
index 000000000000..6f95fb115533
--- /dev/null
+++ b/Documentation/translations/zh_CN/RCU/whatisRCU.rst
@@ -0,0 +1,1220 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/RCU/whatisRCU.rst
+
+:翻译:
+
+ 宋雄微 Xiongwei Song <xiongwei.song@linux.dev>
+
+:校译:
+
+.. _whatisrcu_doc:
+
+什么是RCU - ‘读，拷贝，更新’
+===================================
+
+请注意“什么是RCU？”LWN系列文章是开始学习RCU最好的地方：
+
+| 1.	从根本上说什么是RCU?	  https://lwn.net/Articles/262464/
+| 2.	什么是RCU? 第二部分：使用 https://lwn.net/Articles/263130/
+| 3.	RCU第三部分：RCU API	  https://lwn.net/Articles/264090/
+| 4.	RCU API，2010版		  https://lwn.net/Articles/418853/
+|	2010大API表		  https://lwn.net/Articles/419086/
+| 5.	RCU API，2014版		  https://lwn.net/Articles/609904/
+|	2014大API表		  https://lwn.net/Articles/609973/
+| 6.	RCU API，2019版		  https://lwn.net/Articles/777036/
+|	2019大API表		  https://lwn.net/Articles/777165/
+| 7.	RCU API， 2024版	  https://lwn.net/Articles/988638/
+|	2024背景信息		  https://lwn.net/Articles/988641/
+|	2024大API表		  https://lwn.net/Articles/988666/
+
+对于喜欢视频形式的人:
+
+| 1.	揭开RCU的神秘面纱: 基本原理	https://www.linuxfoundation.org/webinars/unraveling-rcu-usage-mysteries
+
+| 2.	揭开RCU的神秘面纱: 其他使用场景	https://www.linuxfoundation.org/webinars/unraveling-rcu-usage-mysteries-additional-use-cases
+
+什么是RCU？
+
+RCU是一种同步机制，在开发2.5版本时用于优化以读为主的场景而添加到Linux
+内核中。尽管RCU十分简单，要想高效的使用它需要你认真思考代码的场景。这
+个问题的另一部分是错误的假设，认为存在描述和使用RCU的“唯一正确方式”。
+其实不然，经验已经证明不同的人必须用不同的途径实现对RCU的理解，取决于
+他们的经验和使用场景。本文提供若干不同的途径，具体如下：
+
+:ref:`1.	RCU 概述 <1_whatisRCU>`
+
+:ref:`2.	RCU核心API? <2_whatisRCU>`
+
+:ref:`3.	一些RCU核心API的使用样例? <3_whatisRCU>`
+
+:ref:`4.	如果更新线程不能阻塞会怎么样? <4_whatisRCU>`
+
+:ref:`5.	有哪些RCU的简单实现? <5_whatisRCU>`
+
+:ref:`6.	与读写锁的对比 <6_whatisRCU>`
+
+:ref:`7.	与引用计数的对比 <7_whatisRCU>`
+
+:ref:`8.	RCU API的完全列表 <8_whatisRCU>`
+
+:ref:`9.	快速问题答案 <9_whatisRCU>`
+
+喜欢先看概念性概述的人们应更关注第1节，尽管大多数读者在某个阶段阅读
+本节都会获益。喜欢先用API做一些实验的人们应该关注第2节。喜欢先看一下
+使用案例的人们应该关注第3和第4节。想要了解RCU实现的人们应该关注第5节，
+然后再阅读内核代码。擅长通过类比进行推理的人，应重点关注第6节和第7节。
+第8节提供docbookAPI文档索引，第9节回答老生常谈的关键问题。
+
+所以，请以对你来说最有意义和你喜欢的学习方法开始。如果你需要了解所有
+的细节，随便读所有的内容 -- 但如果你真是这类人，你肯定已经看过代码了，
+因此不需要这个文档。;-)
+
+.. _1_whatisRCU:
+
+1. RCU概述
+----------
+
+RCU背后基本的思想是把更新分成“删除”和“回收”两个阶段。删除阶段删除一
+个数据结构中数据项的引用（可能用新版本数据项的引用替换它们），并且
+可以和读端并发运行。可以安全地并发运行读端和删除阶段的原因是现代CPU
+的语义保证读者将会看到数据结构的旧版本或者新版本而不是部分更新的引
+用。回收阶段回收（例如内存释放）删除阶段删除的数据结构中的数据项。
+因为回收数据项可以扰乱任何读者并发引用地那些数据项，所以回收阶段必
+须要在所有的读者不再有那些数据项的引用之后才能开始。
+
+更新分成删除和回收阶段可以使更新者立即执行删除阶段，并且推迟回收阶
+段直到所有在删除阶段活跃的读者都已完成，或者通过阻塞直到它们完成，
+或者注册一个回调函数在它们完成之后调用。只有在删除阶段活跃的读者才
+需要被考虑，因为任何在删除阶段之后开始的读者将不能获取已删除数据的
+引用，因此不能被回收阶段干扰。
+
+所以通常的RCU更新序列步骤如下：
+
+a.	删除一个数据结构的指针，这样后续的读者不能获取它的引用。
+
+b.	等待之前所有的读者完成它们的RCU读端临界区。
+
+c.	在这个时间点，没有任何读者持有这个数据结构的引用，所以它现在
+        可以被安全的回收（例如，被free()释放）。
+
+上面的步骤(b)是延迟释放资源的关键思想。这种等待所有读者完成的能力允许
+RCU读者使用很轻量级的同步方式，在一些情况下，可以完全不用同步。相比而
+言，在传统的基于锁的方案中，读者必须使用重量级的同步阻止更新者在它们
+还在使用数据结构的时候删除。这是因为基于锁的更新者通常在适当的时机更
+新数据项，因此必须排除读者。相比而言，基于RCU的更新者通常利用了现代CPU
+上针对单个对齐指针的写入操作是原子的这一特性，允许没有打断读者的情况
+下原子插入、删除、替换链表中的一个数据项。并发的RCU读者可以继续访问旧
+版本，可以避免原子操作，内存屏障，以及导致通信缓存未命中的操作，在当
+前的SMP计算机系统中代价十分高昂，即使没有锁竞争。
+
+在上面列出的三个步骤过程，更新者执行删除和回收，但是用一个不同的线程
+做回收通常会有很大帮助，实际上Linux内核中的目录项缓存（dcache）就是这
+么做的。即使用一个线程执行更新（上面的步骤a）和回收，但是把它们分开考
+虑也会对理解RCU很有帮助。例如，RCU读者和更新者完全不需要通信，但是RCU
+提供在读者和更新者之间隐式的低开销的通信方式，也就是上面的步骤（b）。
+
+鉴于读者不做任何的同步操作，所以一个回收者怎么确定一个读者完成了？
+继续阅读以了解RCU的API怎么使这种情况变得简单。
+
+.. _2_whatisRCU:
+
+2. RCU的核心API有哪些?
+----------------------
+
+核心API其实非常少：
+
+a.	rcu_read_lock()
+b.	rcu_read_unlock()
+c.	synchronize_rcu() / call_rcu()
+d.	rcu_assign_pointer()
+e.	rcu_dereference()
+
+还有很多RCU API的其他成员，但是其他的可以用这5个API来延申，然而大多数
+实现是call_rcu()回调API而不是synchronize_rcu()。
+
+这5个核心RCU API在下面进行详述，其他18个在以后列举。想要获取更多信息可
+以看内核docbook文档，或者直接看函数头部的注释。
+
+rcu_read_lock()
+^^^^^^^^^^^^^^^
+	void rcu_read_lock(void);
+
+	读者使用这个时间原语通知回收者读者正在进入RCU读端临界区。在RCU读
+	端临界区阻塞是非法的，尽管使能CONFIG_PREEMPT_RCU的内核中可以抢占
+	RCU读端临界区。任何在RCU读端临界区被访问的RCU保护的数据结构都被保
+	证在临界区内不被回收。RCU可以结合引用计数维持对数据结构更长期的引
+	用。
+
+	注意任何禁止底半部、抢占、中断的代码都是进入RCU读端临界区。获取
+	自旋锁也进入RCU读端临界区，即使是不禁止抢占的自旋锁，正如在使能
+	了CONFIG_PREEMPT_RT=y 的内核中那样。休眠锁不进入RCU读端临界区。
+
+rcu_read_unlock()
+^^^^^^^^^^^^^^^^^
+	void rcu_read_unlock(void);
+
+	读者使用这个时间原语通知回收者读者正在退出RCU读端临界区。任何使
+	能底半部、抢占、或者中断的代码也是退出RCU读端临界区。释放自旋锁
+	也是退出RCU读端临界区。
+
+	注意RCU读端临界区可能被嵌套或者重叠。
+
+synchronize_rcu()
+^^^^^^^^^^^^^^^^^
+	void synchronize_rcu(void);
+
+	这个时间原语标记了更新者代码的结束和回收者代码的开始。它通过阻塞
+	直到所有之前存在的RCU读端临界区在所有的CPU上都已完成来实现这个功
+	能。需要注意的是synchronize_rcu()不需要等待任何后续的RCU读端临界
+	区执行完成。例如，考虑下面事件序列::
+
+	         CPU 0                  CPU 1                 CPU 2
+	     ----------------- ------------------------- ---------------
+	 1.  rcu_read_lock()
+	 2.                    enters synchronize_rcu()
+	 3.                                               rcu_read_lock()
+	 4.  rcu_read_unlock()
+	 5.                     exits synchronize_rcu()
+	 6.                                              rcu_read_unlock()
+
+	再重复一次，synchronize_rcu()只等待正在执行的RCU读端临界区完成，
+	不会等待任何再synchronize_rcu()被调用之后的临界区。
+
+	当然，在最后一个之前存在的RCU读端临界区执行完成后，synchronize_rcu()
+	不需要**立即**返回。首先，可能会出现调度延迟。其次，为了改进效率
+	很多RCU实现批量处理请求，这可以导致synchronize_rcu()进一步延迟。
+
+	由于synchronize_rcu()是需要知道读者执行完成了的API，所以它的实现
+	是RCU的关键。为了使RCU在除了读密集场景之外的场景是有用的，
+	synchronize_rcu()的开销必须非常小。
+
+	API call_rcu()是synchronize_rcu()的异步回调形式，会在以后的章节用
+	更多的细节描述。它注册一个函数和参数，在所有正在执行的RCU读端临界
+	区完成以后调用，而不是进行阻塞。这个变种在不允许阻塞或者更新端性
+	能极其重要的情况下非常有用。
+
+	然而，不应该轻易地使用call_rcu()，因为synchronize_rcu()通常使代码
+	更简洁。另外，synchronize_rcu()有一个非常好的特性，如果宽限期被延
+	迟了，它可以自动限制更新速率。这个特性使系统在面对拒绝服务攻击的
+	时候有很好的 恢复力。使用call_rcu()的代码为了获取同样效果的恢复力，
+	应该也限制更新速率。可以查看checklist.rst以了解限制更新速率的方法。
+
+rcu_assign_pointer()
+^^^^^^^^^^^^^^^^^^^^
+	void rcu_assign_pointer(p, typeof(p) v);
+
+	是的，rcu_assign_pointer()**是**一个宏，不过，如果能以这种方式声明
+	函数会很酷。（已经有一些添加重载函数到C语言中的讨论，谁知道会怎样
+	呢？）
+
+	更新者使用这个空间宏给RCU保护的指针赋一个新的值，这是为了使更新者
+	和读者可以安全的通信有关值的更改。这是一个空间宏（相对时间而言）。
+	它不求右值，但是它提供一个指定的编译或者CPU架构所要求的任何编译器
+	指令和内存屏障指令。它的序列特性是一个存储-发布操作，也就是在发布
+	这个指针到那个数据结构的存储操作之前，任何被用于初始化这个数据结
+	构的加载和存储操作都是排好顺序的。
+
+	也许同样重要的是，rcu_assign_pointer()用于记录（1）哪一个指针被RCU
+	保护和（2）一个给定的数据结构可以被其他CPU访问的时间点。尽管说了这
+	么多，rcu_assign_pointer()大多数情况下通过_rcu关键字修饰的链表操作
+	原语被间接使用，比如list_add_rcu()。
+
+rcu_dereference()
+^^^^^^^^^^^^^^^^^
+	typeof(p) rcu_dereference(p);
+
+	就像rcu_assign_pointer()，rcu_dereference()必须被实现为一个宏。
+
+	读者使用这个空间rcu_dereference()宏获取一个RCU保护的指针，它返回一
+	个可以被安全解引用地值。注意rcu_dereference()宏不解引用这个指针，
+	而是它保护对指针以后的解引用。它也为指定的CPU架构执行任何需要的内
+	存屏障指令。当前，只有Alpha架构需要在rcu_dereference()内部执行内存
+	屏障。在其他CPU架构中，它编译为易失性加载操作。然而，没有主流的C编
+	译器遵守地址依赖，所以rcu_dereference()使用volatile转换，结合
+	rcu_dereference.rst中所列出的代码准则，阻止当前的编译器打乱这些依赖。
+
+	通常的编码做法是使用rcu_dereference()拷贝一个RCU保护的指针到一个本
+	地变量，然后解引用这个本地变量，如下所示::
+
+		p = rcu_dereference(head.next);
+		return p->data;
+
+	然而，这个场景中，有人可能很轻易的把这两个步骤结合到下面的表达式中::
+
+		return rcu_dereference(head.next)->data;
+
+	如果你正在获取一个RCU保护的数据结构中的多个成员，使用本地变量会更好。
+	重复调用rcu_dereference()看起来不怎么好看，如果有更新发生，不保证在
+	一个读端临界区中会返回同样的指针，以及在Alpha架构CPU上带来不必要的
+	开销。
+
+	注意，rcu_dereference()宏返回的值只在当前RCU读端临界区的范围内有效 [1]_。
+	例如，下面的用法是不合法的::
+
+		rcu_read_lock();
+		p = rcu_dereference(head.next);
+		rcu_read_unlock();
+		x = p->address; /* BUG!!! */
+		rcu_read_lock();
+		y = p->data;	/* BUG!!! */
+		rcu_read_unlock();
+
+	持有一个引用从一个RCU读端临界区到另一个是非法的，就像持有一个引用从
+	一个基于锁的临界区到另一个临界区一样。相似地，在临界区外使用在临界区
+	内获取的引用也是非法的，就像在正常的基于锁的临界区这么做是非法的一样。
+
+	和rcu_assign_pointer()一样，rcu_dereference()一个重要的功能是记录哪
+	些指针是被RCU保护的，特别是标记一个可能随时发生变化的指针，包括调用
+	rcu_dereference()后立即发生改变的情况。并且，像rcu_assign_pointer()
+	一样，通常不直接调用rcu_dereference()，而是通过关键字_rcu修饰的链表
+	操作原语调用，例如，list_for_each_entry_rcu() [2]_。
+
+..	[1]变种rcu_dereference_protected()可以被用于RCU读端临界区外面，只要
+	被更新端代码获取的锁保护就可以。这个变种避免了锁依赖警告，这种警告
+	当调用rcu_dereference()却没有rcu_read_lock()保护的时候会发生。使用
+	rcu_dereference_protected()也有一个优势，它允许使用rcu_dereference()
+	所禁止的 编译器优化。rcu_dereference_protected()变种接收一个锁依赖
+	表达式，用于指出调用者必须获取哪些锁。如果没有提供所指示的保护，锁
+	依赖会发出警告。查看Design/Requirements/Requirements.rst和API的代码
+	注释以获取更多的细节和使用样例。
+
+..	[2]如果更新端代码和RCU读者都使用list_for_each_entry_rcu()实例，那么
+	可以在参数列表中添加额外的锁依赖表达式。例如，提供一个附加的
+	“lock_is_held(&mylock)”参数，RCU锁依赖代码只会在这个实例在RCU读端临
+	界区之外调用，并且没有mylock的保护下发出警告。
+
+下面的图表展示了每个API怎样在读者、更新者以及回收者之间通信。
+::
+
+
+	    rcu_assign_pointer()
+	                            +--------+
+	    +---------------------->| reader |---------+
+	    |                       +--------+         |
+	    |                           |              |
+	    |                           |              | Protect:
+	    |                           |              | rcu_read_lock()
+	    |                           |              | rcu_read_unlock()
+	    |        rcu_dereference()  |              |
+	    +---------+                 |              |
+	    | updater |<----------------+              |
+	    +---------+                                V
+	    |                                    +-----------+
+	    +----------------------------------->| reclaimer |
+	                                         +-----------+
+	      Defer:
+	      synchronize_rcu() & call_rcu()
+
+
+RCU基础设施观察rcu_read_lock()、rcu_read_unlock()、synchronize_rcu()和
+call_rcu()调用的时间序列，这是为了决定（1）什么时候synchronize_rcu()调
+用可以返回到它的调用者（2）什么时候call_rcu()所传递的回调可以被调用。
+RCU基础设施高效的实现大量的使用了批处理以分摊开销到对应API的多次调用中。
+rcu_assign_pointer()和rcu_dereference()调用通过对上面讨论的RCU保护的指
+针存储和加载传递空间变化。
+
+在Linux内核中至少有3中RCU使用模式。上面的图示展示了最常用的一种。在更新
+端，rcu_assign_pointer()、synchronize_rcu()和call_rcu()原语的使用对3中
+模式来说是一样的。然而对于数据保护（在读端），使用的原语取决于使用模式：
+
+a.	rcu_read_lock() / rcu_read_unlock()
+	rcu_dereference()
+
+b.	rcu_read_lock_bh() / rcu_read_unlock_bh()
+	local_bh_disable() / local_bh_enable()
+	rcu_dereference_bh()
+
+c.	rcu_read_lock_sched() / rcu_read_unlock_sched()
+	preempt_disable() / preempt_enable()
+	local_irq_save() / local_irq_restore()
+	硬中断入口 / 硬中断出口
+	NMI入口 / NMI出口
+	rcu_dereference_sched()
+
+这三种模式使用场景如下：
+
+a.	RCU应用于通常的数据结构。
+
+b.	RCU应用于可能遭受远程拒绝服务攻击的网络数据结构。
+
+c.	RCU应用于调度器和中断/NMI-处理程序任务。
+
+再一次强调，大多数使用场景会是(a)。(b)和(c)对专门的使用场景来说很重要，
+但相对没那么常用。SRCU、RCU-任务、RCU-任务-粗鲁以及RCU-任务-跟踪在它们
+各自类型的原语中有相似的关系。
+
+.. _3_whatisRCU:
+
+3. RCU核心API的使用样例是什么样的?
+----------------------------------
+
+这一节展示了一个简单的RCU核心API的使用样例，用于保护一个动态分配的数据
+结构的全局指针。更多的RCU常用样例可以在listRCU.rst和NMI-RCU.rst找到。
+::
+
+	struct foo {
+		int a;
+		char b;
+		long c;
+	};
+	DEFINE_SPINLOCK(foo_mutex);
+
+	struct foo __rcu *gbl_foo;
+
+	/*
+	 * Create a new struct foo that is the same as the one currently
+	 * pointed to by gbl_foo, except that field "a" is replaced
+	 * with "new_a".  Points gbl_foo to the new structure, and
+	 * frees up the old structure after a grace period.
+	 *
+	 * Uses rcu_assign_pointer() to ensure that concurrent readers
+	 * see the initialized version of the new structure.
+	 *
+	 * Uses synchronize_rcu() to ensure that any readers that might
+	 * have references to the old structure complete before freeing
+	 * the old structure.
+	 */
+	void foo_update_a(int new_a)
+	{
+		struct foo *new_fp;
+		struct foo *old_fp;
+
+		new_fp = kmalloc_obj(*new_fp);
+		spin_lock(&foo_mutex);
+		old_fp = rcu_dereference_protected(gbl_foo, lockdep_is_held(&foo_mutex));
+		*new_fp = *old_fp;
+		new_fp->a = new_a;
+		rcu_assign_pointer(gbl_foo, new_fp);
+		spin_unlock(&foo_mutex);
+		synchronize_rcu();
+		kfree(old_fp);
+	}
+
+	/*
+	 * Return the value of field "a" of the current gbl_foo
+	 * structure.  Use rcu_read_lock() and rcu_read_unlock()
+	 * to ensure that the structure does not get deleted out
+	 * from under us, and use rcu_dereference() to ensure that
+	 * we see the initialized version of the structure (important
+	 * for DEC Alpha and for people reading the code).
+	 */
+	int foo_get_a(void)
+	{
+		int retval;
+
+		rcu_read_lock();
+		retval = rcu_dereference(gbl_foo)->a;
+		rcu_read_unlock();
+		return retval;
+	}
+
+概括起来如下：
+
+-	使用rcu_read_lock()和rcu_read_unlock()守护RCU读端临界区。
+
+-	在一个RCU读端临界区之内, 使用rcu_dereference()解引用RCU保护的指针。
+
+-	使用可靠的设计（例如锁或信号量）保持在互相干扰的情况下并发更新。
+
+-	使用rcu_assign_pointer()更新RCU保护的指针。这个原语在更新端保护并发
+	读者,不是并发更新之间的保护! 因此你仍然需要锁(或相似的机制)在互相干
+	扰的更新者之间保护rcu_assign_pointer()原语并发调用的情况。
+
+-	在一个RCU保护的数据结构中删除一个数据元素以后使用synchronize_rcu()，
+	但是在回收/释放这个数据结构之前，它是为了等待所有可能还在引用那个
+	数据元素的RCU读端临界区完成。
+
+使用RCU时需要遵守的额外准则请看checklist.rst 。再一次强调，更多的RCU使用样
+例可以在listRCU.rst和NMI-RCU.rst找到。
+
+.. _4_whatisRCU:
+
+4. 如果更新线程不能阻塞怎么办?
+------------------------------
+
+在上面的例子中，foo_update_a()阻塞直到优雅期结束。这十分简单，但是在某些
+情况下更新端无法负担太长的等待 -- 可能有其他高优先级的工作需要完成。
+
+在这种情况下，开发者应该使用call_rcu()而不是synchronize_rcu()。call_rcu()
+API如下所示::
+
+	void call_rcu(struct rcu_head *head, rcu_callback_t func);
+
+在一个宽限期结束以后这个函数调用func(head)。这个调用可能发生在软中断或者
+进程上下文中，所以func(head)不被允许阻塞。foo结构体中需要添加一个
+rcu_head结构体，大概如下所示::
+
+	struct foo {
+		int a;
+		char b;
+		long c;
+		struct rcu_head rcu;
+	};
+
+然后函数foo_update_a()可以写成如下所示::
+
+	/*
+	 * Create a new struct foo that is the same as the one currently
+	 * pointed to by gbl_foo, except that field "a" is replaced
+	 * with "new_a".  Points gbl_foo to the new structure, and
+	 * frees up the old structure after a grace period.
+	 *
+	 * Uses rcu_assign_pointer() to ensure that concurrent readers
+	 * see the initialized version of the new structure.
+	 *
+	 * Uses call_rcu() to ensure that any readers that might have
+	 * references to the old structure complete before freeing the
+	 * old structure.
+	 */
+	void foo_update_a(int new_a)
+	{
+		struct foo *new_fp;
+		struct foo *old_fp;
+
+		new_fp = kmalloc_obj(*new_fp);
+		spin_lock(&foo_mutex);
+		old_fp = rcu_dereference_protected(gbl_foo, lockdep_is_held(&foo_mutex));
+		*new_fp = *old_fp;
+		new_fp->a = new_a;
+		rcu_assign_pointer(gbl_foo, new_fp);
+		spin_unlock(&foo_mutex);
+		call_rcu(&old_fp->rcu, foo_reclaim);
+	}
+
+函数foo_reclaim()可能如下所示::
+
+	void foo_reclaim(struct rcu_head *rp)
+	{
+		struct foo *fp = container_of(rp, struct foo, rcu);
+
+		foo_cleanup(fp->a);
+
+		kfree(fp);
+	}
+
+container_of()原语是一个宏，给定一个结构体内的指针、结构体的类型、以及结
+构体内被指向的字段的名称，返回一个结构体开始位置的指针。
+
+call_rcu()的使用允许foo_update_a()的调用者立即重新获得控制权，也不需要过多
+担心新更新元素的旧版本。它也清晰地展示了RCU在更新者，也就是foo_update_a()
+和回收者，也就是foo_reclaim()的区别。
+
+总结概括和之前的一节一样，除了这里使用的是call_rcu()而不是synchronize_rcu()：
+
+-	从一个RCU保护的数据结构中删除一个数据元素以后调用call_rcu()，这是
+	为了注册一个回调函数，在所有可能引用那个数据项的RCU读端临界区完成
+	之后被调用。
+
+如果这个call_rcu()中的回调函数不会比调用kfree()在这个数据结构上做的工作更
+多，你可以使用kfree_rcu()代替call_rcu()以避免你必须写自己的回调函数::
+
+	kfree_rcu(old_fp, rcu);
+
+如果偶尔的睡眠被允许，可以使用单个参数的形式。省去struct foo中的rcu_head
+结构::
+
+	kfree_rcu_mightsleep(old_fp);
+
+这个变种几乎从来不阻塞，但是可能通过调用synchronize_rcu()阻塞以应对内存
+分配失败的情况。
+
+再一次强调，更多额外的RCU管理规则请看checklist.rst。
+
+.. _5_whatisRCU:
+
+5. RCU有哪些简单的实现?
+-----------------------
+
+RCU其中一个好玩的点是它有极其简单的“玩具”实现，它们是朝着理解Linux内核
+中产品级实现的不错的第一步。这一节呈现了两个RCU的“玩具”实现，其中一个
+使用熟悉的锁原语，另一个更接近“经典”RCU。这两个例子对真实的场景来说太
+简单，缺少功能和性能。然而，它们对于理解RCU是怎么工作的非常有用。浏览
+kernel/rcu/update.c以了解产品级实现，以及关于描述RCU实现的论文请看：
+
+	https://docs.google.com/document/d/1X0lThx8OK0ZgLMqVoXiR4ZrGURHrXK6NyLRbeXe3Xac/edit
+
+OLS’01和OLS’02论文是不错的介绍，专题论文提供最早自2004年到目前实现的更
+多细节。
+
+5A. “玩具”实现 #1: 锁
+^^^^^^^^^^^^^^^^^^^^^
+这一节展示了一个基于熟悉的锁原语的“玩具”RCU实现。它的开销使它在现实
+生活中不会成为被首先使用的方法，因为它缺乏可伸缩性。它也不适用于实时
+场景，因为它允许调度延迟，这可能导致从一个读端临界区“渗透”到另一个
+读端临界区。它也假定使用的是递归读写锁：如果你对非递归锁进行这种操作，
+并且你允许rcu_read_lock()嵌套调用，则会导致死锁。
+
+然而，它可能是最简单的实现，所以是一个好的开始。
+
+它极其简单::
+
+	static DEFINE_RWLOCK(rcu_gp_mutex);
+
+	void rcu_read_lock(void)
+	{
+		read_lock(&rcu_gp_mutex);
+	}
+
+	void rcu_read_unlock(void)
+	{
+		read_unlock(&rcu_gp_mutex);
+	}
+
+	void synchronize_rcu(void)
+	{
+		write_lock(&rcu_gp_mutex);
+		smp_mb__after_spinlock();
+		write_unlock(&rcu_gp_mutex);
+	}
+
+[你可以忽略rcu_assign_pointer()和rcu_dereference()，也没有错过太多内容。
+但是不管怎么样这是简化版本。无论你做什么，当提交使用RCU的补丁的时候不要
+忘记它们！]::
+
+	#define rcu_assign_pointer(p, v) \
+	({ \
+		smp_store_release(&(p), (v)); \
+	})
+
+	#define rcu_dereference(p) \
+	({ \
+		typeof(p) _________p1 = READ_ONCE(p); \
+		(_________p1); \
+	})
+
+rcu_read_lock()和rcu_read_unlock()原语读操作获取和释放一个全局读写锁。
+synchronize_rcu()原语写操作获取同样的锁，然后释放它。这意味着一旦
+synchronize_rcu()退出，所有的在synchronize_rcu()被调用之前的RCU读端临
+界区保证都已经执行完成了 -- 否则synchronize_rcu()没有办法获取写锁。
+smp_mb__after_spinlock()提升synchronize_rcu()为全内存屏障，以遵守下面
+文章列出的“内存屏障保证”：
+
+	Design/Requirements/Requirements.rst
+
+是可以嵌套rcu_read_lock()的，因为读写锁可以被递归获取。也要注意rcu_read_lock()
+是死锁免疫的（RCU的一个重要特性）。原因是唯一可以阻塞rcu_read_lock()的是
+synchronize_rcu()调用。但是synchronize_rcu()在持有rcu_gp_mutex的时候不获
+取任何其他锁，所以不可能有死锁循环。
+
+.. _quiz_1:
+
+快速测验 #1:
+		为什么这个论点是幼稚的？当在真实的Linux内核使用这个算法
+		的时候可能怎么样发生死锁？这个死锁可以怎么被避免？
+
+:ref:`回答快速测验 <9_whatisRCU>`
+
+5B. “玩具” 例子 #2: 经典 RCU
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+这一节展示了一个基于“经典RCU”的玩具RCU实现。它在性能方面（仅限于更新操作）
+和功能（例如CPU热插拔，以及使能CONFIG_PREEMPTION内核下运行的能力）上有所
+欠缺。rcu_dereference()和rcu_assign_pointer()的定义和之前章节所展示的一样，
+所以这里省略它们。
+::
+
+	void rcu_read_lock(void) { }
+
+	void rcu_read_unlock(void) { }
+
+	void synchronize_rcu(void)
+	{
+		int cpu;
+
+		for_each_possible_cpu(cpu)
+			run_on(cpu);
+	}
+
+注意rcu_read_lock()和rcu_read_unlock()绝对什么也不做。这是经典RCU在非抢占
+内核中的伟大力量：读端开销精确到0，至少在非Alpha架构上是这样的。
+rcu_read_lock()绝对没有可能陷入一个死锁循环！
+
+synchronize_rcu()的实现简单地依次在每个CPU上调度它自己。run_on()原语可以
+基于sched_setaffinity()原语直接实现。当然，稍微不那么“玩具”的实现会在操作
+一完成后就恢复亲和性，而不是留下所以的任务在最后一个CPU上运行，但是当我说
+“玩具”地时候，它就是个 **玩具** ！
+
+所以这到底应该怎么工作？
+
+记住在一个RCU读端临界区阻塞是非法的。因此，如果一个给定的CPU执行了一次
+上下文切换，我们知道它肯定已经完成了之前所有的读端临界区。一旦所有的CPU
+都执行了上下文切换，那么所有之前的RCU读端临界区都已经完成了。
+
+所以，假定我们从一个数据结构中删除了一个数据项，然后调用synchronize_rcu()。
+一旦synchronize_rcu()返回，我们被保证没有RCU读端临界区持有那个数据项的引用，
+所以我们可以安全的回收它。
+
+.. _quiz_2:
+
+快速测验 #2:
+		举一个经典RCU读端临界区的开销是**负**的例子。
+
+:ref:`快速测验答案 <9_whatisRCU>`
+
+.. _quiz_3:
+
+快速测验 #3:
+		如果阻塞一个RCU读端临界区是非法的，在使能CONFIG_PREEMPT_RT的
+		内核中自旋锁转为睡眠锁，那你怎么做？？？
+
+:ref:`快速测验答案 <9_whatisRCU>`
+
+.. _6_whatisRCU:
+
+6. 与读写锁类比
+---------------
+
+尽管RCU的使用方式有很多种，但其中一种非常常见的用法与读写锁类似。下面
+的差异展示了相关的RCU和读写锁可以多接近。
+::
+
+	@@ -5,5 +5,5 @@ struct el {
+		int data;
+		/* Other data fields */
+	 };
+	-rwlock_t listmutex;
+	+spinlock_t listmutex;
+	 struct el head;
+
+	@@ -13,15 +14,15 @@
+		struct list_head *lp;
+		struct el *p;
+
+	-	read_lock(&listmutex);
+	-	list_for_each_entry(p, head, lp) {
+	+	rcu_read_lock();
+	+	list_for_each_entry_rcu(p, head, lp) {
+	 		if (p->key == key) {
+	 			*result = p->data;
+	-			read_unlock(&listmutex);
+	+			rcu_read_unlock();
+	 			return 1;
+			}
+		}
+	-	read_unlock(&listmutex);
+	+	rcu_read_unlock();
+		return 0;
+	 }
+
+	@@ -29,15 +30,16 @@
+	 {
+		struct el *p;
+
+	-	write_lock(&listmutex);
+	+	spin_lock(&listmutex);
+		list_for_each_entry(p, head, lp) {
+			if (p->key == key) {
+	-			list_del(&p->list);
+	-			write_unlock(&listmutex);
+	+			list_del_rcu(&p->list);
+	+			spin_unlock(&listmutex);
+	+			synchronize_rcu();
+				kfree(p);
+				return 1;
+			}
+		}
+	-	write_unlock(&listmutex);
+	+	spin_unlock(&listmutex);
+		return 0;
+	 }
+
+或者，并排排列::
+
+ 1 struct el {                          1 struct el {
+ 2   struct list_head list;             2   struct list_head list;
+ 3   long key;                          3   long key;
+ 4   spinlock_t mutex;                  4   spinlock_t mutex;
+ 5   int data;                          5   int data;
+ 6   /* Other data fields */            6   /* Other data fields */
+ 7 };                                   7 };
+ 8 rwlock_t listmutex;                  8 spinlock_t listmutex;
+ 9 struct el head;                      9 struct el head;
+
+::
+
+  1 int search(long key, int *result)    1 int search(long key, int *result)
+  2 {                                    2 {
+  3   struct list_head *lp;              3   struct list_head *lp;
+  4   struct el *p;                      4   struct el *p;
+  5                                      5
+  6   read_lock(&listmutex);             6   rcu_read_lock();
+  7   list_for_each_entry(p, head, lp) { 7   list_for_each_entry_rcu(p, head, lp) {
+  8     if (p->key == key) {             8     if (p->key == key) {
+  9       *result = p->data;             9       *result = p->data;
+ 10       read_unlock(&listmutex);      10       rcu_read_unlock();
+ 11       return 1;                     11       return 1;
+ 12     }                               12     }
+ 13   }                                 13   }
+ 14   read_unlock(&listmutex);          14   rcu_read_unlock();
+ 15   return 0;                         15   return 0;
+ 16 }                                   16 }
+
+::
+
+  1 int delete(long key)                 1 int delete(long key)
+  2 {                                    2 {
+  3   struct el *p;                      3   struct el *p;
+  4                                      4
+  5   write_lock(&listmutex);            5   spin_lock(&listmutex);
+  6   list_for_each_entry(p, head, lp) { 6   list_for_each_entry(p, head, lp) {
+  7     if (p->key == key) {             7     if (p->key == key) {
+  8       list_del(&p->list);            8       list_del_rcu(&p->list);
+  9       write_unlock(&listmutex);      9       spin_unlock(&listmutex);
+                                        10       synchronize_rcu();
+ 10       kfree(p);                     11       kfree(p);
+ 11       return 1;                     12       return 1;
+ 12     }                               13     }
+ 13   }                                 14   }
+ 14   write_unlock(&listmutex);         15   spin_unlock(&listmutex);
+ 15   return 0;                         16   return 0;
+ 16 }                                   17 }
+
+两种方案的差异非常小。读端锁改为rcu_read_lock()和rcu_read_unlock，更新端
+锁从一个读写锁改为一个简单的自旋锁。然后，在调用kfree()之前调用
+synchronize_rcu()。
+
+然而，有一个潜在的问题：读端和更新端临界区现在可以并发运行。在很多情况下，
+这不是问题，但是不管怎么样必须认真检查。例如，如果多个独立的链表更新必须
+被视为一个原子更新，转换到RCU需要特别小心。
+
+另外，synchronize_rcu()的出现意味着RCU的delete()版本能够阻塞。如果这是一
+个问题，有一个基于回调函数的从来不会阻塞的机制，也就是call_rcu()或者
+kfree_rcu()，可以用它们替换synchronize_rcu()。
+
+.. _7_whatisRCU:
+
+7. 与引用计数类比
+-----------------
+
+与读写锁的对比（在前面一节被阐述的）并不总是理解怎么使用RCU最好的途径。
+另一个有帮助的对比是把RCU视为所有被RCU保护对象的有效引用计数。
+
+一个引用计数典型地不阻止被引用地对象值的改变，而是阻止其类型改变 --
+特别是极端的变化，这会在那个对象的内存被释放之后又被重新分配用于其他
+目的的时候发生。一旦获取这个对象的类型安全的引用，则需要一些其他机制
+确保对对象中的数据的一致访问。这可能需要获取一个自旋锁，但是对于RCU
+来说，通常的途径是使用支持SMP的操作执行读取，例如smp_load_acquire()，
+使用原子的读-修改-写操作执行更新，并且提供必须的内存访问序列。RCU提供
+一些了内嵌这些被要求的操作和内存序列的函数，例如上一节使用的
+list_for_each_entry_rcu()宏。
+
+一个说明是引用计数行为的视角是在rcu_read_lock()和rcu_read_unlock()之
+间，任何通过rcu_dereference()获取的且用 ``__rcu`` 标记的指针的引用可
+以被视为在那个对象上的一个引用计数已经被临时递增了，这样阻止了对象类
+型的变更。这具体意味着什么，取决于对该类型对象的正常预期，但是它通常
+包括自旋锁仍然可以被安全地加锁，正常的引用计数可以被安全地操作，并且
+``__rcu`` 修饰的指针可以被安全地解引用。
+
+人们可能预期看到那些被持有RCU引用的对象上的操作包括：
+
+ - 拷贝出被保证对象类型稳定的数据
+ - 调用kref_get_unless_zero()或者相似的函数获取一个更长期的引用。当然
+   可能失败。
+ - 获取对象中的一个自旋锁，检查这个对象是否仍然是预期的那一个，如果是
+   则可以使用它。
+
+对于RCU提供一个只阻止类型变更的引用的理解特别显而易见的是从slab缓存分
+配的被标记为 ``SLAB_TYPESAFE_BY_RCU`` 的对象。RCU操作可能从这种缓存中
+获取一个对象的引用，而这个对象已经被并发释放了，并且被分配为一个完全
+不同的对象，即使它们类型相同。在这种情况下，RCU甚至不保护这个对象实体
+的改变，而只保护它的类型。所以这个对象可能被发现不是预期的那一个，但
+是可以安全的从这个对象获取引用（然后潜在地获取一个自旋锁），允许后续
+的代码检查是否这个实体匹配预期。在不获取引用的情况下仅仅获取自旋锁是
+十分诱人的，但是不幸的是任何有 ``SLAB_TYPESAFE_BY_RCU`` 标志的对象中
+的自旋锁必须在每次调用kmem_cache_alloc()后被初始化，这使得在不获取引
+用的情况下获取自旋锁变得完全不安全。因此当使用
+``SLAB_TYPESAFE_BY_RCU`` 标志的时候，需要适当的使用引用计数。如果使用
+refcount_t，当验证对象实体以及初始化新分配的对象的时候，应该使用专用
+的refcount_{add|inc}_not_zero_acquire()和refcount_set_release()API以
+确保正确的操作顺序。refcount\_{add|inc}_not_zero_acquire()中的获取屏
+障确保实体检查发生在引用计数被获取之后。新分配的对象被完全初始化之后
+应该调用refcount_set_release()，释放屏障确保引用计数可以被其他用户成
+功获取之前新的值是可见的。一旦调用了refcount_set_release()，这个对象
+应该被视为对其他任务可见。（那些希望在kmem_cache构造函数中初始化他们
+的锁的用户，也可以使用锁机制，包括缓存友好的顺序锁。）
+
+对于传统的引用计数来说 -- 例如在Linux中那些通过kref库实现的引用计数
+-- 通常会有一段代码在一个对象的最后一个引用被丢弃后执行。对于使用kref
+来说，这段代码是通过kref_put()传递的函数。当使用RCU的时候，直到所有引
+用这个对象的 ``__rcu`` 指针被更新，并且宽限期已经结束之后，这种终止化
+代码才能运行。每一个对这个对象保持全局可见的指针必须被考虑为一个潜在
+的被计数的引用，在所有这些指针被变更之后，通常才运行使用call_rcu()传
+递的终止化代码。
+
+在RCU作为读写锁和作为引用计数系统的类比中到底应该怎么选 -- 可以从反应
+被保护事物的规模角度出发。读写锁类比主要注重包含有多个部分的更大的对
+象，例如链表，它展示出从链表上添加和删除元素时RCU怎么更容易处理并发。
+引用计数类比着眼于单个对象，以及不管它们是哪个组件的一部分这些对象都
+可以被安全的访问。
+
+.. _8_whatisRCU:
+
+8. RCU API完全列表
+------------------
+
+RCU API以docbook格式的头文件注释形式记录在Linux内核源码中，但是一个API
+完全列表也是有帮助的，因为在docbook中没有什么方法将把它们分类。这里是
+分类后的列表。
+
+RCU链表遍历::
+
+	list_entry_rcu
+	list_entry_lockless
+	list_first_entry_rcu
+	list_first_or_null_rcu
+	list_tail_rcu
+	list_next_rcu
+	list_next_or_null_rcu
+	list_for_each_entry_rcu
+	list_for_each_entry_continue_rcu
+	list_for_each_entry_from_rcu
+	list_for_each_entry_lockless
+	hlist_first_rcu
+	hlist_next_rcu
+	hlist_pprev_rcu
+	hlist_for_each_entry_rcu
+	hlist_for_each_entry_rcu_notrace
+	hlist_for_each_entry_rcu_bh
+	hlist_for_each_entry_from_rcu
+	hlist_for_each_entry_continue_rcu
+	hlist_for_each_entry_continue_rcu_bh
+	hlist_nulls_first_rcu
+	hlist_nulls_next_rcu
+	hlist_nulls_for_each_entry_rcu
+	hlist_nulls_for_each_entry_safe
+	hlist_bl_first_rcu
+	hlist_bl_for_each_entry_rcu
+
+RCU 指针/列表更新::
+
+	rcu_assign_pointer
+	rcu_replace_pointer
+	INIT_LIST_HEAD_RCU
+	list_add_rcu
+	list_add_tail_rcu
+	list_del_rcu
+	list_replace_rcu
+	list_splice_init_rcu
+	list_splice_tail_init_rcu
+	hlist_add_behind_rcu
+	hlist_add_before_rcu
+	hlist_add_head_rcu
+	hlist_add_tail_rcu
+	hlist_del_rcu
+	hlist_del_init_rcu
+	hlist_replace_rcu
+	hlist_nulls_del_init_rcu
+	hlist_nulls_del_rcu
+	hlist_nulls_add_head_rcu
+	hlist_nulls_add_tail_rcu
+	hlist_nulls_add_fake
+	hlists_swap_heads_rcu
+	hlist_bl_add_head_rcu
+	hlist_bl_del_rcu
+	hlist_bl_set_first_rcu
+
+RCU::
+
+	Critical sections		Grace period		Barrier
+
+	rcu_read_lock			synchronize_net		rcu_barrier
+	rcu_read_unlock			synchronize_rcu
+	guard(rcu)()			synchronize_rcu_expedited
+	scoped_guard(rcu)		synchronize_rcu_mult
+	rcu_dereference			call_rcu
+	rcu_dereference_check		call_rcu_hurry
+	rcu_dereference_protected	kfree_rcu
+	rcu_read_lock_held		kvfree_rcu
+	rcu_read_lock_any_held		kfree_rcu_mightsleep
+	rcu_pointer_handoff		cond_synchronize_rcu
+	unrcu_pointer			cond_synchronize_rcu_full
+					cond_synchronize_rcu_expedited
+					cond_synchronize_rcu_expedited_full
+					get_completed_synchronize_rcu
+					get_completed_synchronize_rcu_full
+					get_state_synchronize_rcu
+					get_state_synchronize_rcu_full
+					poll_state_synchronize_rcu
+					poll_state_synchronize_rcu_full
+					same_state_synchronize_rcu
+					same_state_synchronize_rcu_full
+					start_poll_synchronize_rcu
+					start_poll_synchronize_rcu_full
+					start_poll_synchronize_rcu_expedited
+					start_poll_synchronize_rcu_expedited_full
+
+bh::
+
+	Critical sections	Grace period		Barrier
+
+	rcu_read_lock_bh	[Same as RCU]		[Same as RCU]
+	rcu_read_unlock_bh
+	[local_bh_disable]
+	[and friends]
+	rcu_dereference_bh
+	rcu_dereference_bh_check
+	rcu_dereference_bh_protected
+	rcu_read_lock_bh_held
+
+sched::
+
+	Critical sections	Grace period		Barrier
+
+	rcu_read_lock_sched	[Same as RCU]		[Same as RCU]
+	rcu_read_unlock_sched
+	[preempt_disable]
+	[and friends]
+	rcu_read_lock_sched_notrace
+	rcu_read_unlock_sched_notrace
+	rcu_dereference_sched
+	rcu_dereference_sched_check
+	rcu_dereference_sched_protected
+	rcu_read_lock_sched_held
+
+
+RCU：初始化/清理/内存序列::
+
+	RCU_INIT_POINTER
+	RCU_INITIALIZER
+	RCU_POINTER_INITIALIZER
+	init_rcu_head
+	destroy_rcu_head
+	init_rcu_head_on_stack
+	destroy_rcu_head_on_stack
+	SLAB_TYPESAFE_BY_RCU
+
+
+RCU：静止态和控制::
+
+	cond_resched_tasks_rcu_qs
+	rcu_all_qs
+	rcu_softirq_qs_periodic
+	rcu_end_inkernel_boot
+	rcu_expedite_gp
+	rcu_gp_is_expedited
+	rcu_unexpedite_gp
+	rcu_cpu_stall_reset
+	rcu_head_after_call_rcu
+	rcu_is_watching
+
+
+RCU同步原语::
+
+	rcu_sync_is_idle
+	rcu_sync_init
+	rcu_sync_enter
+	rcu_sync_exit
+	rcu_sync_dtor
+
+
+RCU任务::
+
+	Critical sections	Grace period			Barrier
+
+	N/A			call_rcu_tasks			rcu_barrier_tasks
+				synchronize_rcu_tasks
+
+
+RCU-任务-粗鲁::
+
+	Critical sections	Grace period			Barrier
+
+	N/A			synchronize_rcu_tasks_rude	rcu_barrier_tasks_rude
+				call_rcu_tasks_rude
+
+
+RCU-任务-跟踪::
+
+	Critical sections	Grace period			Barrier
+
+	rcu_read_lock_trace	call_rcu_tasks_trace		rcu_barrier_tasks_trace
+	rcu_read_unlock_trace	synchronize_rcu_tasks_trace
+	guard(rcu_tasks_trace)()
+	scoped_guard(rcu_tasks_trace)
+
+
+SRCU链表遍历::
+
+	list_for_each_entry_srcu
+	hlist_for_each_entry_srcu
+
+
+SRCU::
+
+	Critical sections		Grace period		Barrier
+
+	srcu_read_lock			call_srcu		srcu_barrier
+	srcu_read_unlock		synchronize_srcu
+	srcu_read_lock_fast		synchronize_srcu_expedited
+	srcu_read_unlock_fast		get_state_synchronize_srcu
+	srcu_read_lock_nmisafe		start_poll_synchronize_srcu
+	srcu_read_unlock_nmisafe	start_poll_synchronize_srcu_expedited
+	srcu_read_lock_notrace		poll_state_synchronize_srcu
+	srcu_read_unlock_notrace
+	srcu_down_read
+	srcu_up_read
+	srcu_down_read_fast
+	srcu_up_read_fast
+	guard(srcu)()
+	scoped_guard(srcu)
+	srcu_read_lock_held
+	srcu_dereference
+	srcu_dereference_check
+	srcu_dereference_notrace
+	srcu_read_lock_held
+
+
+SRCU:初始化/清理/内存序列::
+
+	DEFINE_SRCU
+	DEFINE_STATIC_SRCU
+	DEFINE_SRCU_FAST        // for srcu_read_lock_fast() and friends
+	DEFINE_STATIC_SRCU_FAST // for srcu_read_lock_fast() and friends
+	init_srcu_struct
+	init_srcu_struct_fast
+	cleanup_srcu_struct
+	smp_mb__after_srcu_read_unlock
+
+所有的：lockdep检查的RCU多功能API::
+
+	RCU_LOCKDEP_WARN
+	rcu_sleep_check
+
+所有的：未检查的受RCU保护的指针的访问::
+
+	rcu_dereference_raw
+
+所有的：禁止对未检查的 RCU 保护的指针的解引用访问::
+
+	rcu_access_pointer
+
+更多信息，请看源代码头文件中的注释（或者通过这些头文件生成的docbook）。
+
+然而，在Linux内核中有不少于4种RCU API家族，你应该怎么选使用哪一个？
+下面列表中的描述会十分有帮助：
+
+a.	读端需要阻塞吗？如果需要，那么选SRCU。
+
+b.	读端需要阻塞吗？需要执行跟踪吗，例如ftrace或者BPF？如果需要，
+	那么选择RCU-任务、RCU-任务-粗鲁形式、或者RCU-任务-跟踪。
+
+c.	需要-rt补丁集吗？如果读端需要在非-rt内核中阻塞，那么选择SRCU。
+	如果读端在-rt内核中获取自旋锁的时候需要阻塞，但是在一个非-rt
+	内核中不需要，那么就不要选择SRCU。（-rt补丁集转换自旋锁为休眠
+	锁，因此会有这个不同。）
+
+d.	你需要将NMI处理程序、硬中断处理程序以及关抢占（通过
+	preempt_disable(), local_irq_save(), local_bh_disable()或者其
+	他机制）的代码片段视为显示的RCU读端吗？如果是，RCU-sched读端
+	是唯一的选择，但是大约从v4.20版本开始，您可以在更新端使用原始
+	的RCU更新原语。
+
+e.	你需要面对软中断独占一个或多个CPU时RCU宽限期也需要结束的情况吗?
+	例如，你的代码容易遭受基于网络的拒绝服务攻击吗？如果是这种情况，
+	你应该在执行读端临界区时禁止软中断，例如，调用rcu_read_lock_bh()
+	。大约从v4.20 版本开始，您可以在更新端使用原始的 RCU 更新原语。
+
+f.	你的工作负载场景对于正常RCU的过于频繁的更新十分敏感，但是也没有
+	其他合适的同步机制吗？如果是这种场景，考虑一下
+	SLAB_TYPESAFE_BY_RCU（原来是SLAB_DESTROY_BY_RCU）。但是请小心使
+	用。
+
+g.	你是否需要RCU读端临界区在CPU处于深度空闲循环、在进入用户模式或
+	者从用户模式退出、或者CPU离线的情况下不被干扰吗？如果是这些情况，
+	唯二的选择是SRCU和RCU任务跟踪，几乎在所有情况下SRCU基本上是更好
+	的选择。
+
+h.	否则，使用RCU。
+
+当然，这些都假设你已经了解RCU对你的工作来说是正确的工具。
+
+.. _9_whatisRCU:
+
+9. 快速测验答案
+---------------
+
+快速测验 #1：
+		为什么这个论点（玩具A中的做法不会死锁）是幼稚的？当在真
+		实的Linux内核中使用这个算法的时候怎么可能发生死锁？[指
+		的是基于锁的“玩具”RCU算法。]
+
+回答:
+		考虑下列事件序列：
+
+		1.	CPU0获取不相关的锁，我们称它为“problematic_lock”，
+			通过调用spin_lock_irqsave()禁止了中断。
+
+		2.	CPU1进入synchronize_rcu()，获取rcu_gp_mutex写锁。
+
+		3.	CPU0进入rcu_read_lock()，但是必须等待因为CPU1持有
+			rcu_gp_mutex。
+
+		4.	CPU1被中断，中断处理程序试图获取problematic_lock。
+
+		现在系统是死锁状态。
+
+		一个避免这个死锁的方法是使用例如使能内核中的
+		CONFIG_PREEMPT_RT，这样所有正常的自旋锁变成了阻塞锁，并且
+		所有的中断处理程序在特别的进程上下文中执行。在这种情况下，
+		上面的步骤4，中断处理程序会阻塞，允许CPU1释放rcu_gp_mutex，
+		避免这个死锁。
+
+		即使这种死锁不存在，这个RCU实现通过synchronize_rcu()也可以
+		使延迟从一个读端漫延到其他读端。为了观察到这种情况，考虑任
+		务A在一个读端临界区中（因此持有rcu_gp_mutex读锁），任务B
+		阻塞试图获取rcu_gp_mutex写锁，任务C阻塞在rcu_read_lock()中
+		试图获取rcu_gp_mutex读锁。任务A的RCU读端延迟延误了任务C，
+		尽管这个延迟不是直接来自于任务B。
+
+		因此实时内核中的RCU实现使用一个基于计数器的方法，在RCU读端
+		临界区执行的任务不能被执行synchronize_rcu()的任务阻塞。
+
+:ref:`回到快速测验 #1 <quiz_1>`
+
+快速测验 #2:
+		举一个经典RCU读端临界区的开销是**负**的例子。
+
+回答：
+		想象一个单CPU的系统，运行关闭CONFIG_PREEMPTION（关抢占）的
+		内核，一个路由表被进程上下文的代码使用，但是它可以被中断
+		上下文代码更新（例如，“ICMP REDIRECT”包）。处理这种情况通常
+		的办法是在搜索路由表的时候在进程上下文关闭中断。使用RCU可以
+		免除这种关中断的操作。因此，没有RCU的话，你需要为关中断付出
+		代价，然而使用RCU则不需要。
+
+		人们可以说就单CPU系统中关中断的场景RCU的开销是负的。也有
+		其他人可能说任务RCU的开销是0，用0开销RCU方案替代关中断方案
+		的正开销不被视为负开销。
+
+		在现实生活中，当然事情往往更复杂。但是对一个同步原语来说，
+		即使负开销理论上的可能性也是出人意料的。
+
+:ref:`回到快速测验 #2 <quiz_2>`
+
+快速测验 #3:
+		如果阻塞一个RCU读端临界区是非法的，在使能CONFIG_PREEMPT_RT
+		的内核中自旋锁转为睡眠锁，那你怎么做？？？
+
+回答：
+		就因为使能CONFIG_PREEMPT_RT的内核允许自旋锁临界区的抢占，
+		所以它允许RCU读端临界区的抢占。也就是它允许自旋锁在RCU读端
+		临界区中阻塞。
+
+		为什么会有明显的不一致？因为必要时可以使用优先级提升保持RCU
+		宽限期不会持续过长（例如，如果遇到内存不足问题）。相比而言，
+		假如阻塞等待网络数据接收，则没有办法知道应该提升哪个任务的
+		优先级。特别是假如我们需要提升的进程正好是一个出去买披萨或
+		者什么东西的人。并且尽管电脑控制的赶牛鞭子可能会引起浓厚兴
+		趣，但也可能招致强烈的反对。另外，计算机怎么知道这个人类去
+		了哪个披萨店？？？
+
+:ref:`回到快速测验 #3 <quiz_3>`
+
+致谢
+
+感谢帮助完成文档可读性的伙伴，他们有Jon Walpole，Josh Triplett，Serge Hallyn，
+Suzanne Wood， 以及Alan Stern。
+
+
+更多信息请参考 http://www.rdrop.com/users/paulmck/RCU。
-- 
2.52.0


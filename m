Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530243;
	b=MO6pVVqqZ9n9jgbK/NnDCXoglwqzqHXpOlQmlpHPZtljoJGaLBGrVXh8WiCnN+0ItENR
	 XHxHUn43pf2u+3eyQBKalcxCl41ELkNqek2+YsBnmdXaMiBy5L88iItnh8lU9dJ7VgyuU
	 tTdnlVgJO5ogy3i1gQzSX1ln3oxy/lZBsAWLdYFNOo2k99b04D3CNgUxYzj2EzR6Pn83k
	 Nv3fFIv8LnSOANRjip7xpJvdzi8hewGo5GRL0JL8YJBVHnJhZZlZh3x4LalR5iyzRCITh
	 62hFps3e4Z5qXRE3fLvHoz03G6rXHwNOtRAZGgCVp1WeC/dZ+enq66Jt0DDuRnEjc4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530243;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=//50TV5iuj3B0xg7o1Kiy093nQQtvUKBTDn6yn0ilK0=;
	b=vMk69EjEuQAD8Q6vvnpC01uOCjsxSwXy4unVHDWaac8t8hupWjaJq677r438dU73BI7H
	 ewS27Ml5Mb3XTC2+0nwu2s+zkoY9lOv20zTMtQMU8cbCEQInXqKm+AoFNkuSz2v/4lRcm
	 l65P5zLoAABl44B6js3uUXpQQVFsxEOeYc55tg9i9Iny9jK/208GtqpmLH0kMI1zC03Bi
	 sglaPx6UOiMqaozVa1AfDE+pINInbonK7UeTtAPGSyFyoF0UOE5OLz1fhZeiLnh/VW/7q
	 TBXswSHnDZwayv4vc1jlhBAu2qlmxsgH4wEVBAuHMaJlwA2S3OaOaEX9KMdTY+V2dFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Kj9zA2l5;
	arc=none smtp.remote-ip=95.215.58.104
Received: from mta1.migadu.com (out-104.mta1.migadu.com [95.215.58.104])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E52606A331
	for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 14:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6E52606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Kj9zA2l5
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=roBtUiQwvgvwsbAal/VFe8QLVdZJt0GlqQLvFc2k7HU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795530240; v=1; x=1796135040;
 b=Kj9zA2l5cmhU0j1Zl9Ggx9hMmjkpPuuTdB4ce6A+8jUDpxXsZcr2MTEfAbNZMneis17o/vEL
 z7nHUHDhAkggdmyZY5MrUly8RDOdR6G+v7NqBtP0MR+2XxQsRk120IFHXcMTP7RFnsjTUafsDbt
 9j0QTJX4GcAtd7Q4XNHNUM3M=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 88dc93bae4e7a5f7;
	Tue, 24 Nov 2026 14:24:00 +0000
X-Mizu-Trace-ID: 88dc93bae4e7a5f7
X-Migadu-Flow: FLOW_OUT
Message-ID: <946792d2-4241-445d-820b-301a570ee2c3@linux.dev>
Date: Tue, 24 Nov 2026 22:23:50 +0800
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] docs/zh_CN: Add RCU/whatisRCU.rst Chinese
 translation
To: Dongliang Mu <dzm91@hust.edu.cn>, alexs@kernel.org, si.yanteng@linux.dev
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 paulmck@kernel.org, linux-doc@vger.kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261118131636.5131-1-xiongwei.song@linux.dev>
 <20261118131636.5131-3-xiongwei.song@linux.dev>
 <09ef3d3d-0e68-49c6-a6a2-c754104ede9e@hust.edu.cn>
From: Bruce Song <xiongwei.song@linux.dev>
In-Reply-To: <09ef3d3d-0e68-49c6-a6a2-c754104ede9e@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dongliang,

On 11/23/2026 10:35 PM, Dongliang Mu wrote:
> 
> On 11/18/26 9:16 PM, xiongwei.song@linux.dev wrote:
>> From: Xiongwei Song <xiongwei.song@linux.dev>
>>
>> Translate .../RCU/whatisRCU.rst into Chinese.
>>
>> Update the translation through commit b3eb16109ae1
>> ("doc: Update stallwarn.rst based on RCU Tasks Trace as SRCU")
>>
>> Signed-off-by: Xiongwei Song <xiongwei.song@linux.dev>
> 
> 
> |Documentation/translations/zh_CN/RCU/whatisRCU.rst:688: space before 
> tab in indent. Documentation/translations/zh_CN/RCU/whatisRCU.rst:689: 
> space before tab in indent. Documentation/translations/zh_CN/RCU/ 
> whatisRCU.rst:692: space before tab in indent.|
> 
> |Please fix their indentation as well. Dongliang Mu |

Thank you for pointing this out. I remeber I copied the code block from
the original doc, but they were changed somehow.

> 
> 
>> ---
>>   .../translations/zh_CN/RCU/index.rst          |    3 +-
>>   .../translations/zh_CN/RCU/whatisRCU.rst      | 1220 +++++++++++++++++
>>   2 files changed, 1222 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/translations/zh_CN/RCU/whatisRCU.rst
>>
>> diff --git a/Documentation/translations/zh_CN/RCU/index.rst b/ 
>> Documentation/translations/zh_CN/RCU/index.rst
>> index 3675da1a2993..8de47d142811 100644
>> --- a/Documentation/translations/zh_CN/RCU/index.rst
>> +++ b/Documentation/translations/zh_CN/RCU/index.rst
>> @@ -19,6 +19,8 @@ RCU Handbook
>>   .. toctree::
>>      :maxdepth: 2
>> +   whatisRCU
>> +
>>   TODOLIST:
>>   * checklist
>> @@ -26,7 +28,6 @@ TODOLIST:
>>   * lockdep-splat
>>   * rcubarrier
>>   * rcu_dereference
>> -* whatisRCU
>>   * rcu
>>   * rculist_nulls
>>   * rcuref
>> diff --git a/Documentation/translations/zh_CN/RCU/whatisRCU.rst b/ 
>> Documentation/translations/zh_CN/RCU/whatisRCU.rst
>> new file mode 100644
>> index 000000000000..d1a2e2991615
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/RCU/whatisRCU.rst
>> @@ -0,0 +1,1220 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/RCU/whatisRCU.rst
>> +
>> +:翻译:
>> +
>> + 宋雄微 Xiongwei Song <xiongwei.song@linux.dev>
>> +
>> +:校译:
>> +
>> +.. _zh_cn_whatisrcu_doc:
> 
> 
> Please double check all the references. If one reference is not referred 
> from other places, please remove it in the translation.

Ok, I will do that.

> 
> 
>> +
>> +什么是RCU - ‘读，拷贝，更新’
>> +===================================
>> +
>> +请注意“什么是RCU？”LWN系列文章是开始学习RCU最好的地方：
>> +
>> +| 1.    从根本上说什么是RCU?      https://lwn.net/Articles/262464/
>> +| 2.    什么是RCU? 第二部分：使用 https://lwn.net/Articles/263130/
>> +| 3.    RCU第三部分：RCU API      https://lwn.net/Articles/264090/
>> +| 4.    RCU API，2010版          https://lwn.net/Articles/418853/
>> +|    2010大API表          https://lwn.net/Articles/419086/
>> +| 5.    RCU API，2014版          https://lwn.net/Articles/609904/
>> +|    2014大API表          https://lwn.net/Articles/609973/
>> +| 6.    RCU API，2019版          https://lwn.net/Articles/777036/
>> +|    2019大API表          https://lwn.net/Articles/777165/
>> +| 7.    RCU API， 2024版      https://lwn.net/Articles/988638/
>> +|    2024背景信息          https://lwn.net/Articles/988641/
>> +|    2024大API表          https://lwn.net/Articles/988666/
>> +
>> +对于喜欢视频形式的人:
>> +
>> +| 1.    揭开RCU的神秘面纱: 基本原理    https:// 
>> www.linuxfoundation.org/webinars/unraveling-rcu-usage-mysteries
>> +
>> +| 2.    揭开RCU的神秘面纱: 其他使用场景    https:// 
>> www.linuxfoundation.org/webinars/unraveling-rcu-usage-mysteries- 
>> additional-use-cases
>> +
>> +什么是RCU？
>> +
>> +RCU是一种同步机制，在开发2.5版本时用于优化以读为主的场景而添加到Linux
>> +内核中。尽管RCU十分简单，要想高效的使用它需要你认真思考代码的场景。这
>> +个问题的另一部分是错误的假设，认为存在描述和使用RCU的“唯一正确方式”。
>> +其实不然，经验已经证明不同的人必须用不同的途径实现对RCU的理解，取决于
>> +他们的经验和使用场景。本文提供若干不同的途径，具体如下：
>> +
>> +:ref:`1.    RCU 概述 <zh_cn_1_whatisRCU>`
>> +
>> +:ref:`2.    RCU核心API? <zh_cn_2_whatisRCU>`
>> +
>> +:ref:`3.    一些RCU核心API的使用样例? <zh_cn_3_whatisRCU>`
>> +
>> +:ref:`4.    如果更新线程不能阻塞会怎么样? <zh_cn_4_whatisRCU>`
>> +
>> +:ref:`5.    有哪些RCU的简单实现? <zh_cn_5_whatisRCU>`
>> +
>> +:ref:`6.    与读写锁的对比 <zh_cn_6_whatisRCU>`
>> +
>> +:ref:`7.    与引用计数的对比 <zh_cn_7_whatisRCU>`
>> +
>> +:ref:`8.    RCU API的完全列表 <zh_cn_8_whatisRCU>`
>> +
>> +:ref:`9.    快速问题答案 <zh_cn_9_whatisRCU>`
>> +
>> +喜欢先看概念性概述的人们应更关注第1节，尽管大多数读者在某个阶段阅读
>> +本节都会获益。喜欢先用API做一些实验的人们应该关注第2节。喜欢先看一下
>> +使用案例的人们应该关注第3和第4节。想要了解RCU实现的人们应该关注第5节，
>> +然后再阅读内核代码。擅长通过类比进行推理的人，应重点关注第6节和第7节。
>> +第8节提供docbookAPI文档索引，第9节回答老生常谈的关键问题。
>> +
>> +所以，请以对你来说最有意义和你喜欢的学习方法开始。如果你需要了解所有
>> +的细节，随便读所有的内容 -- 但如果你真是这类人，你肯定已经看过代码了，
>> +因此不需要这个文档。;-)
>> +
>> +.. _zh_cn_1_whatisRCU:
>> +
>> +1. RCU概述
>> +----------
>> +
>> +RCU背后基本的思想是把更新分成“删除”和“回收”两个阶段。删除阶段删除一
>> +个数据结构中数据项的引用（可能用新版本数据项的引用替换它们），并且
>> +可以和读端并发运行。可以安全地并发运行读端和删除阶段的原因是现代CPU
>> +的语义保证读者将会看到数据结构的旧版本或者新版本而不是部分更新的引
>> +用。回收阶段回收（例如内存释放）删除阶段删除的数据结构中的数据项。
>> +因为回收数据项可以扰乱任何读者并发引用地那些数据项，所以回收阶段必
>> +须要在所有的读者不再有那些数据项的引用之后才能开始。
>> +
>> +更新分成删除和回收阶段可以使更新者立即执行删除阶段，并且推迟回收阶
>> +段直到所有在删除阶段活跃的读者都已完成，或者通过阻塞直到它们完成，
>> +或者注册一个回调函数在它们完成之后调用。只有在删除阶段活跃的读者才
>> +需要被考虑，因为任何在删除阶段之后开始的读者将不能获取已删除数据的
>> +引用，因此不能被回收阶段干扰。
>> +
>> +所以通常的RCU更新序列步骤如下：
>> +
>> +a.    删除一个数据结构的指针，这样后续的读者不能获取它的引用。
>> +
>> +b.    等待之前所有的读者完成它们的RCU读端临界区。
>> +
>> +c.    在这个时间点，没有任何读者持有这个数据结构的引用，所以它现在
>> +    可以被安全的回收（例如，被free()释放）。
>> +
>> +上面的步骤(b)是延迟释放资源的关键思想。这种等待所有读者完成的能力允许
>> +RCU读者使用很轻量级的同步方式，在一些情况下，可以完全不用同步。相比而
>> +言，在传统的基于锁的方案中，读者必须使用重量级的同步阻止更新者在它们
>> +还在使用数据结构的时候删除。这是因为基于锁的更新者通常在适当的时机更
>> +新数据项，因此必须排除读者。相比而言，基于RCU的更新者通常利用了现代CPU
>> +上针对单个对齐指针的写入操作是原子的这一特性，允许没有打断读者的情况
>> +下原子插入、删除、替换链表中的一个数据项。并发的RCU读者可以继续访问旧
>> +版本，可以避免原子操作，内存屏障，以及导致通信缓存未命中的操作，在当
>> +前的SMP计算机系统中代价十分高昂，即使没有锁竞争。
>> +
>> +在上面列出的三个步骤过程，更新者执行删除和回收，但是用一个不同的线程
>> +做回收通常会有很大帮助，实际上Linux内核中的目录项缓存（dcache）就是这
>> +么做的。即使用一个线程执行更新（上面的步骤a）和回收，但是把它们分开考
>> +虑也会对理解RCU很有帮助。例如，RCU读者和更新者完全不需要通信，但是RCU
>> +提供在读者和更新者之间隐式的低开销的通信方式，也就是上面的步骤（b）。
>> +
>> +鉴于读者不做任何的同步操作，所以一个回收者怎么确定一个读者完成了？
>> +继续阅读以了解RCU的API怎么使这种情况变得简单。
>> +
>> +.. _zh_cn_2_whatisRCU:
>> +
>> +2. RCU的核心API有哪些?
>> +----------------------
>> +
>> +核心API其实非常少：
>> +
>> +a.    rcu_read_lock()
>> +b.    rcu_read_unlock()
>> +c.    synchronize_rcu() / call_rcu()
>> +d.    rcu_assign_pointer()
>> +e.    rcu_dereference()
>> +
>> +还有很多RCU API的其他成员，但是其他的可以用这5个API来延申，然而大多数
>> +实现是call_rcu()回调API而不是synchronize_rcu()。
>> +
>> +这5个核心RCU API在下面进行详述，其他18个在以后列举。想要获取更多信息可
>> +以看内核docbook文档，或者直接看函数头部的注释。
>> +
>> +rcu_read_lock()
>> +^^^^^^^^^^^^^^^
>> +    void rcu_read_lock(void);
>> +
>> +    读者使用这个时间原语通知回收者读者正在进入RCU读端临界区。在RCU读
>> +    端临界区阻塞是非法的，尽管使能CONFIG_PREEMPT_RCU的内核中可以抢占
>> +    RCU读端临界区。任何在RCU读端临界区被访问的RCU保护的数据结构都被保
>> +    证在临界区内不被回收。RCU可以结合引用计数维持对数据结构更长期的引
>> +    用。
>> +
>> +    注意任何禁止底半部、抢占、中断的代码都是进入RCU读端临界区。获取
>> +    自旋锁也进入RCU读端临界区，即使是不禁止抢占的自旋锁，正如在使能
>> +    了CONFIG_PREEMPT_RT=y 的内核中那样。休眠锁不进入RCU读端临界区。
>> +
>> +rcu_read_unlock()
>> +^^^^^^^^^^^^^^^^^
>> +    void rcu_read_unlock(void);
>> +
>> +    读者使用这个时间原语通知回收者读者正在退出RCU读端临界区。任何使
>> +    能底半部、抢占、或者中断的代码也是退出RCU读端临界区。释放自旋锁
>> +    也是退出RCU读端临界区。
>> +
>> +    注意RCU读端临界区可能被嵌套或者重叠。
>> +
>> +synchronize_rcu()
>> +^^^^^^^^^^^^^^^^^
>> +    void synchronize_rcu(void);
>> +
>> +    这个时间原语标记了更新者代码的结束和回收者代码的开始。它通过阻塞
>> +    直到所有之前存在的RCU读端临界区在所有的CPU上都已完成来实现这个功
>> +    能。需要注意的是synchronize_rcu()不需要等待任何后续的RCU读端临界
>> +    区执行完成。例如，考虑下面事件序列::
>> +
>> +             CPU 0                  CPU 1                 CPU 2
>> +         ----------------- ------------------------- ---------------
>> +     1.  rcu_read_lock()
>> +     2.                    enters synchronize_rcu()
>> +     3.                                               rcu_read_lock()
>> +     4.  rcu_read_unlock()
>> +     5.                     exits synchronize_rcu()
>> +     6.                                              rcu_read_unlock()
>> +
>> +    再重复一次，synchronize_rcu()只等待正在执行的RCU读端临界区完成，
>> +    不会等待任何再synchronize_rcu()被调用之后的临界区。
> 
> 
> |The original documentation says that synchronize_rcu() does not 
> necessarily wait for critical sections that begin after it is invoked. 
> It may still wait for some of them, so please change “不会等待” to “不一 
> 定会等待”.|

Good catch. I misunderstood "Not necessarily" here.

> 
> 
>> +
>> +    当然，在最后一个之前存在的RCU读端临界区执行完成后，synchronize_rcu()
>> +    不需要**立即**返回。首先，可能会出现调度延迟。其次，为了改进效率
>> +    很多RCU实现批量处理请求，这可以导致synchronize_rcu()进一步延迟。
>> +
>> +    由于synchronize_rcu()是需要知道读者执行完成了的API，所以它的实现
>> +    是RCU的关键。为了使RCU在除了读密集场景之外的场景是有用的，
>> +    synchronize_rcu()的开销必须非常小。
>> +
>> +    API call_rcu()是synchronize_rcu()的异步回调形式，会在以后的章节用
>> +    更多的细节描述。它注册一个函数和参数，在所有正在执行的RCU读端临界
>> +    区完成以后调用，而不是进行阻塞。这个变种在不允许阻塞或者更新端性
>> +    能极其重要的情况下非常有用。
>> +
>> +    然而，不应该轻易地使用call_rcu()，因为synchronize_rcu()通常使代码
>> +    更简洁。另外，synchronize_rcu()有一个非常好的特性，如果宽限期被延
>> +    迟了，它可以自动限制更新速率。这个特性使系统在面对拒绝服务攻击的
>> +    时候有很好的 恢复力。使用call_rcu()的代码为了获取同样效果的恢复力，
>> +    应该也限制更新速率。可以查看checklist.rst以了解限制更新速率的方法。
>> +
>> +rcu_assign_pointer()
>> +^^^^^^^^^^^^^^^^^^^^
>> +    void rcu_assign_pointer(p, typeof(p) v);
>> +
>> +    是的，rcu_assign_pointer()**是**一个宏，不过，如果能以这种方式声明
>> +    函数会很酷。（已经有一些添加重载函数到C语言中的讨论，谁知道会怎样
>> +    呢？）
>> +
>> +    更新者使用这个空间宏给RCU保护的指针赋一个新的值，这是为了使更新者
>> +    和读者可以安全的通信有关值的更改。这是一个空间宏（相对时间而言）。
>> +    它不求右值，但是它提供一个指定的编译或者CPU架构所要求的任何编译器
>> +    指令和内存屏障指令。它的序列特性是一个存储-发布操作，也就是在发布
> 
> 
> |The original documentation says that rcu_assign_pointer() does not 
> evaluate to an rvalue. The translation instead says that it does not 
> evaluate the right-hand operand. Please clarify that the macro itself 
> does not yield an rvalue.|

 From my understanding, "rvalue" is a term of C language, which is "右值" 
in Chinese，it basically means a value in the right-hand side of the 
equal sign that can't be stored to a memory location directly but 
assgined to a lvalue. It doesn't mean the right-hand operand. Here, it's 
rcu_assign_pointer() doesn't return any value to be assgined a rvalue. 
Or am I missing something?

> 
> 
>> +    这个指针到那个数据结构的存储操作之前，任何被用于初始化这个数据结
>> +    构的加载和存储操作都是排好顺序的。
>> +
>> +    也许同样重要的是，rcu_assign_pointer()用于记录（1）哪一个指针被RCU
>> +    保护和（2）一个给定的数据结构可以被其他CPU访问的时间点。尽管说了这
>> +    么多，rcu_assign_pointer()大多数情况下通过_rcu关键字修饰的链表操作
>> +    原语被间接使用，比如list_add_rcu()。
>> +
>> +rcu_dereference()
>> +^^^^^^^^^^^^^^^^^
>> +    typeof(p) rcu_dereference(p);
>> +
>> +    就像rcu_assign_pointer()，rcu_dereference()必须被实现为一个宏。
>> +
>> +    读者使用这个空间rcu_dereference()宏获取一个RCU保护的指针，它返回一
>> +    个可以被安全解引用地值。注意rcu_dereference()宏不解引用这个指针，
>> +    而是它保护对指针以后的解引用。它也为指定的CPU架构执行任何需要的内
>> +    存屏障指令。当前，只有Alpha架构需要在rcu_dereference()内部执行内存
>> +    屏障。在其他CPU架构中，它编译为易失性加载操作。然而，没有主流的C编
>> +    译器遵守地址依赖，所以rcu_dereference()使用volatile转换，结合
>> +    rcu_dereference.rst中所列出的代码准则，阻止当前的编译器打乱这些依 
>> 赖。
>> +
>> +    通常的编码做法是使用rcu_dereference()拷贝一个RCU保护的指针到一个本
>> +    地变量，然后解引用这个本地变量，如下所示::
>> +
>> +        p = rcu_dereference(head.next);
>> +        return p->data;
>> +
>> +    然而，这个场景中，有人可能很轻易的把这两个步骤结合到下面的表达式中::
>> +
>> +        return rcu_dereference(head.next)->data;
>> +
>> +    如果你正在获取一个RCU保护的数据结构中的多个成员，使用本地变量会更 
>> 好。
>> +    重复调用rcu_dereference()看起来不怎么好看，如果有更新发生，不保证在
>> +    一个读端临界区中会返回同样的指针，以及在Alpha架构CPU上带来不必要的
>> +    开销。
>> +
>> +    注意，rcu_dereference()宏返回的值只在当前RCU读端临界区的范围内有 
>> 效 [1]_。
>> +    例如，下面的用法是不合法的::
>> +
>> +        rcu_read_lock();
>> +        p = rcu_dereference(head.next);
>> +        rcu_read_unlock();
>> +        x = p->address; /* BUG!!! */
>> +        rcu_read_lock();
>> +        y = p->data;    /* BUG!!! */
>> +        rcu_read_unlock();
>> +
>> +    持有一个引用从一个RCU读端临界区到另一个是非法的，就像持有一个引用从
>> +    一个基于锁的临界区到另一个临界区一样。相似地，在临界区外使用在临界区
>> +    内获取的引用也是非法的，就像在正常的基于锁的临界区这么做是非法的 
>> 一样。
>> +
>> +    和rcu_assign_pointer()一样，rcu_dereference()一个重要的功能是记录哪
>> +    些指针是被RCU保护的，特别是标记一个可能随时发生变化的指针，包括调用
>> +    rcu_dereference()后立即发生改变的情况。并且，像rcu_assign_pointer()
>> +    一样，通常不直接调用rcu_dereference()，而是通过关键字_rcu修饰的链表
>> +    操作原语调用，例如，list_for_each_entry_rcu() [2]_。
>> +
>> +..    [1] 变种rcu_dereference_protected()可以被用于RCU读端临界区外面，只
>> +    要被更新端代码获取的锁保护就可以。这个变种避免了锁依赖警告，这种警
>> +    告当调用rcu_dereference()却没有rcu_read_lock()保护的时候会发生。使
>> +    用rcu_dereference_protected()也有一个优势，它允许使用 
>> rcu_dereference()
>> +    所禁止的 编译器优化。rcu_dereference_protected()变种接收一个锁依赖
>> +    表达式，用于指出调用者必须获取哪些锁。如果没有提供所指示的保护，锁
>> +    依赖会发出警告。查看Design/Requirements/Requirements.rst和API的代码
>> +    注释以获取更多的细节和使用样例。
>> +
>> +..    [2] 如果更新端代码和RCU读者都使用list_for_each_entry_rcu()实例，那
>> +    么可以在参数列表中添加额外的锁依赖表达式。例如，提供一个附加的
>> +    “lock_is_held(&mylock)”参数，RCU锁依赖代码只会在这个实例在RCU读端临
>> +    界区之外调用，并且没有mylock的保护下发出警告。
>> +
>> +下面的图表展示了每个API怎样在读者、更新者以及回收者之间通信。
>> +::
>> +
>> +
>> +        rcu_assign_pointer()
>> +                                +--------+
>> +        +---------------------->| reader |---------+
>> +        |                       +--------+         |
>> +        |                           |              |
>> +        |                           |              | Protect:
>> +        |                           |              | rcu_read_lock()
>> +        |                           |              | rcu_read_unlock()
>> +        |        rcu_dereference()  |              |
>> +        +---------+                 |              |
>> +        | updater |<----------------+              |
>> +        +---------+                                V
>> +        |                                    +-----------+
>> +        +----------------------------------->| reclaimer |
>> +                                             +-----------+
>> +          Defer:
>> +          synchronize_rcu() & call_rcu()
>> +
>> +
>> +RCU基础设施观察rcu_read_lock()、rcu_read_unlock()、synchronize_rcu()和
>> +call_rcu()调用的时间序列，这是为了决定（1）什么时候synchronize_rcu()调
>> +用可以返回到它的调用者（2）什么时候call_rcu()所传递的回调可以被调用。
>> +RCU基础设施高效的实现大量的使用了批处理以分摊开销到对应API的多次调用中。
>> +rcu_assign_pointer()和rcu_dereference()调用通过对上面讨论的RCU保护的指
>> +针存储和加载传递空间变化。
>> +
>> +在Linux内核中至少有3中RCU使用模式。上面的图示展示了最常用的一种。在更新
>> +端，rcu_assign_pointer()、synchronize_rcu()和call_rcu()原语的使用对3中
>> +模式来说是一样的。然而对于数据保护（在读端），使用的原语取决于使用模式：
>> +
>> +a.    rcu_read_lock() / rcu_read_unlock()
>> +    rcu_dereference()
>> +
>> +b.    rcu_read_lock_bh() / rcu_read_unlock_bh()
>> +    local_bh_disable() / local_bh_enable()
>> +    rcu_dereference_bh()
>> +
>> +c.    rcu_read_lock_sched() / rcu_read_unlock_sched()
>> +    preempt_disable() / preempt_enable()
>> +    local_irq_save() / local_irq_restore()
>> +    硬中断入口 / 硬中断出口
>> +    NMI入口 / NMI出口
>> +    rcu_dereference_sched()
>> +
>> +这三种模式使用场景如下：
>> +
>> +a.    RCU应用于通常的数据结构。
>> +
>> +b.    RCU应用于可能遭受远程拒绝服务攻击的网络数据结构。
>> +
>> +c.    RCU应用于调度器和中断/NMI-处理程序任务。
>> +
>> +再一次强调，大多数使用场景会是(a)。(b)和(c)对专门的使用场景来说很重要，
>> +但相对没那么常用。SRCU、RCU-任务、RCU-任务-粗鲁以及RCU-任务-跟踪在它们
>> +各自类型的原语中有相似的关系。
>> +
>> +.. _zh_cn_3_whatisRCU:
>> +
>> +3. RCU核心API的使用样例是什么样的?
>> +----------------------------------
>> +
>> +这一节展示了一个简单的RCU核心API的使用样例，用于保护一个动态分配的数据
>> +结构的全局指针。更多的RCU常用样例可以在listRCU.rst和NMI-RCU.rst找到。
>> +::
>> +
>> +    struct foo {
>> +        int a;
>> +        char b;
>> +        long c;
>> +    };
>> +    DEFINE_SPINLOCK(foo_mutex);
>> +
>> +    struct foo __rcu *gbl_foo;
>> +
>> +    /*
>> +     * Create a new struct foo that is the same as the one currently
>> +     * pointed to by gbl_foo, except that field "a" is replaced
>> +     * with "new_a".  Points gbl_foo to the new structure, and
>> +     * frees up the old structure after a grace period.
>> +     *
>> +     * Uses rcu_assign_pointer() to ensure that concurrent readers
>> +     * see the initialized version of the new structure.
>> +     *
>> +     * Uses synchronize_rcu() to ensure that any readers that might
>> +     * have references to the old structure complete before freeing
>> +     * the old structure.
>> +     */
>> +    void foo_update_a(int new_a)
>> +    {
>> +        struct foo *new_fp;
>> +        struct foo *old_fp;
>> +
>> +        new_fp = kmalloc_obj(*new_fp);
>> +        spin_lock(&foo_mutex);
>> +        old_fp = rcu_dereference_protected(gbl_foo, 
>> lockdep_is_held(&foo_mutex));
>> +        *new_fp = *old_fp;
>> +        new_fp->a = new_a;
>> +        rcu_assign_pointer(gbl_foo, new_fp);
>> +        spin_unlock(&foo_mutex);
>> +        synchronize_rcu();
>> +        kfree(old_fp);
>> +    }
>> +
>> +    /*
>> +     * Return the value of field "a" of the current gbl_foo
>> +     * structure.  Use rcu_read_lock() and rcu_read_unlock()
>> +     * to ensure that the structure does not get deleted out
>> +     * from under us, and use rcu_dereference() to ensure that
>> +     * we see the initialized version of the structure (important
>> +     * for DEC Alpha and for people reading the code).
>> +     */
>> +    int foo_get_a(void)
>> +    {
>> +        int retval;
>> +
>> +        rcu_read_lock();
>> +        retval = rcu_dereference(gbl_foo)->a;
>> +        rcu_read_unlock();
>> +        return retval;
>> +    }
>> +
>> +概括起来如下：
>> +
>> +-    使用rcu_read_lock()和rcu_read_unlock()守护RCU读端临界区。
>> +
>> +-    在一个RCU读端临界区之内, 使用rcu_dereference()解引用RCU保护的指针。
>> +
>> +-    使用可靠的设计（例如锁或信号量）保持在互相干扰的情况下并发更新。
> 
> 
> |The original says to use locks or semaphores to prevent concurrent 
> updates from interfering with each other. Please change this to “使用可 
> 靠的设计（例如锁或信号量）防止并发更新互相干扰”。|

The verb in original doc is "keep", and the objective is "updates" here. 
IMO, "prevent" has changed the original meaning, and the objective has 
been changed to "interfering with each other". Or do you have any other 
thoughts?

Thank you for your time. This doc is relatively long, it's not easy to 
review. I really appreciate your help.

Regards,
Xiongwei.

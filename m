Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919917085A;
	Sat, 28 Sep 2024 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727524238; cv=none; b=qRzNiEwWdVnZwUCNKDa1T2Fbl8BhhXJvGioem8haQUYDIO6lEbnZYxKgGY5XgBGRswhL/ftebp7VF3fNnyUZOznEb7/hT8l6u9ZzEDdNDTTCsokMMkHWZDwiQbF+Et75dMYPMYBLU2UDLFdVOasQN//OtvcLG6UNiWscp5wVgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727524238; c=relaxed/simple;
	bh=8P3Zw7MFYAZvL1cGHyTuojhG3OvEjU0fxG4TGXibf5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0vaKZVpKU9+za7ireHkf0ubYbcKsVQrdZhDXlhFbHqDaJxlBuLkMSU62LexizeUFxPMcLXp0GpswE56MvHgNqP6wwaKeONS/R6GCNfUDscBiKUjzs7+xq/9pMK4ZYn/5vB9TMiaoCbZXkDTNGOTQJLodwW6kaPVBQ8C/6ed/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XG4kC4QzHz9v7JM;
	Sat, 28 Sep 2024 19:24:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 8CB4E1401F0;
	Sat, 28 Sep 2024 19:50:32 +0800 (CST)
Received: from [10.81.205.100] (unknown [10.81.205.100])
	by APP2 (Coremail) with SMTP id GxC2BwBHqcl47fdm4VvRAQ--.57124S2;
	Sat, 28 Sep 2024 12:50:31 +0100 (CET)
Message-ID: <42709627-8bb9-4f9f-beeb-dde9bd420022@huaweicloud.com>
Date: Sat, 28 Sep 2024 13:50:13 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] hpref: Hazard Pointers with Reference Counter
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Alan Stern
 <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev
References: <20240921164210.256278-1-mathieu.desnoyers@efficios.com>
 <db17633f-354d-428e-97c2-bcd455766c3a@huaweicloud.com>
 <2ca589bc-2a60-48ef-95a0-d9ee4a814dea@efficios.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <2ca589bc-2a60-48ef-95a0-d9ee4a814dea@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBHqcl47fdm4VvRAQ--.57124S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFW7JF1ftF4UXr1DZry5Jwb_yoWxAwcEvw
	nrCa15Ar43JF4xW347JF13GrWfJrWvkr4UJw18CF47Zry5ZFnxCFn3CryIy3WfG3yUC3s0
	qryrX3yUZr9xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jxCz
	tUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/

Thanks for your response,

Am 9/28/2024 um 1:33 PM schrieb Mathieu Desnoyers:
> 
> This is a userspace prototype. This will behave similarly to a userspace
> spinlock in that case, which is not great in terms of CPU usage, but
> should eventually unblock the waiter, unless it has a RT priority that
> really prevents any progress from the emergency slot owner.
> 
> On my TODO list, I have a bullet about integrating with sys_futex to
> block on wait, wake up on slot release. I would then use the wait/wakeup
> code based on sys_futex already present in liburcu.

Oh, I see. I think if it is for userspace then it really should use 
wait/wakeup as you said.

Best wishes,
   jonas


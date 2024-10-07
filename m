Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADC18A6AD;
	Mon,  7 Oct 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302124; cv=none; b=JJpyFup09NOwwgBvBFId10Dvr7r5igVaQLRIHbh4A2kQOE5UMVUKHq1+KldjW+vsI1X9c4BuKnrSjbF/+5fS1LUg9W5Sl6W3stsMMgI/XyXRjyRgDdkrXysXsPzp7hRQD6m9GcHPq4Y9MUFloDhfnM1AgxwAIrltiYL7G9fTCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302124; c=relaxed/simple;
	bh=00nusLTC8SWiuC+fpur6GJmcVCdh17datpoLcZt6X90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRj0oa+2gzDu2KHX31G0YQ4u0q/TSmVGBlvqgtEXinjP/3q7sKwFsJho6QFcCTjkZIStXkkUcOwO6vgAmt7Qw5tiiSyWBE0mI/AuUJ1s1s3yCSG98DiC/YsZnIyr+n93JL9d5USF0jW4K1y2LHVNKPBOFf4L2Ni3zLXrKjR8qpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XMcP76Tf3z9v7JM;
	Mon,  7 Oct 2024 19:29:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 91F4C140628;
	Mon,  7 Oct 2024 19:55:02 +0800 (CST)
Received: from [10.45.154.49] (unknown [10.45.154.49])
	by APP1 (Coremail) with SMTP id LxC2BwDXGjIFzANnlL5hAg--.48334S2;
	Mon, 07 Oct 2024 12:55:01 +0100 (CET)
Message-ID: <6ae2461a-e509-4c4d-8959-ae17eb214419@huaweicloud.com>
Date: Mon, 7 Oct 2024 13:54:43 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 'Alan Stern' <stern@rowland.harvard.edu>,
 David Laight <David.Laight@aculab.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 John Stultz <jstultz@google.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>,
 "maged.michael@gmail.com" <maged.michael@gmail.com>,
 Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "lkmm@lists.linux.dev" <lkmm@lists.linux.dev>
References: <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <9539c551-5c91-42db-8ac1-cff1d6d7c293@huaweicloud.com>
 <2cdda043-1ad9-40cf-a157-0c16a0ffb046@rowland.harvard.edu>
 <5d7d8a59-57f5-4125-95bb-fda9c193b9cf@huaweicloud.com>
 <82e97ad5-17ad-418d-8791-22297acc7af4@rowland.harvard.edu>
 <ea02ce2ce8a348efa8d461f84f976478@AcuMS.aculab.com>
 <2b1caba3-48fa-43b9-bd44-cf60b9a141d7@rowland.harvard.edu>
 <22638e2fe1274eb0834fa3e43b44184e@AcuMS.aculab.com>
 <d192cf63-a274-4721-968e-a2c098db523b@rowland.harvard.edu>
 <e39c6e5975f345c4b1a97145e207dee4@AcuMS.aculab.com>
 <68dc00b3-1ca1-42bc-8f1e-78ace10e4d64@rowland.harvard.edu>
 <bd93a57c-662f-470e-8ba4-509f27eada6d@efficios.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <bd93a57c-662f-470e-8ba4-509f27eada6d@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwDXGjIFzANnlL5hAg--.48334S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF17CF4xGFy7Ww4UtrWxXrb_yoWDXFg_ur
	yFyF9rCw4rX3Wktr4YqF13Z34agFZruw1xZrWkGr4Sv345GwsxuryDXr92vw1fXF4qvFnx
	GryxWw17A34qvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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



Am 10/3/2024 um 3:23 PM schrieb Mathieu Desnoyers:
> What _does_ work however are the following two approaches:
> 
> 1) Perform the equality check on the original variables, creating
> new versions (with OPTIMIZER_HIDE_VAR) of both variables for the
> rest of their use, therefore making sure the pointer dereference
> are not derived from versions of the variables which were compared
> with another pointer. (as suggested by Boqun)

This should not be guaranteed to work, because right after the 
comparison the compiler can do b=a, then it doesn't matter how much you 
hide afterwards.

However it might work if you escape the addresses of a and b first, in 
which case the compiler will not do b=a anymore, but it might force the 
compiler to put a and b on the stack, which has some performance impact.

> 
> 2) Perform the equality check on the versions resulting of hiding
> both variables, making sure those versions of the variables are
> not dereferenced afterwards. (as suggested by Linus)
> 


jonas


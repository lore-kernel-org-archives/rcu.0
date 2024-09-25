Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2214037F;
	Wed, 25 Sep 2024 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258812; cv=none; b=lFsqQuFyHHyvLuUxoC+lXKZ8qr1LHIiV4DoVhhJOIUGpGRciysou+ySA1N1ZhWsYKyXmmwlcG5ePwkuF+ra7z1XeeO2hgktaeTObwahjOWshZNGOtZ8O4GiN/hDBq7skQxbPQ4RaAnxsww+X5UWXphY8Xntt9eImlpcBZlim93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258812; c=relaxed/simple;
	bh=FPRD666LMhdvP+lcHLT9OxVZv6e01nd/FLUR4GiY0Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZD/TubaRuBaqHy1AapJHRfHGvmszYTlpz8rCDyJzTn8KsaZjcYw0Bmfejg1HrhHIJ8MN1aLXN4BPsZ+RFGuzGTkhskvNdCo2LfgxlYbXap/Tm3X7EeF8yKF1uySGZaoZWUmVWZMWYhFt364mApgv+otv55xMaE4S9hDGy1F1Vbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XDBhj5c3Vz9v7N8;
	Wed, 25 Sep 2024 17:47:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 13D6D140590;
	Wed, 25 Sep 2024 18:06:44 +0800 (CST)
Received: from [10.45.145.58] (unknown [10.45.145.58])
	by APP2 (Coremail) with SMTP id GxC2BwD3psej4PNmhg+eAQ--.32700S2;
	Wed, 25 Sep 2024 11:06:43 +0100 (CET)
Message-ID: <07c9285f-44a1-486a-8390-0c63cefae35a@huaweicloud.com>
Date: Wed, 25 Sep 2024 12:06:24 +0200
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
 <e4721439-8cad-4134-8c07-84b6ecc69573@huaweicloud.com>
 <48ae741e-98aa-49d9-b677-6c4f8fd1bcb0@efficios.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <48ae741e-98aa-49d9-b677-6c4f8fd1bcb0@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwD3psej4PNmhg+eAQ--.32700S2
X-Coremail-Antispam: 1UD129KBjvJXoWruw1xtr48JF4DuFyUur1kGrg_yoW8JF17pr
	Z7KFy7CFyDGF9akryxtw1UZ348AFZYvas8XaykWrnrZa95WryFqr1SkF1UuF93Aws7XryU
	trWrArZxCasrJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIF
	4iUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 9/25/2024 um 8:35 AM schrieb Mathieu Desnoyers:
> On 2024-09-25 07:57, Jonas Oberhauser wrote:
>> Hi Mathieu,

>> I haven't read your code in detail but it seems to me you have an ABA 
>> bug: as I explained elsewhere, you could read the same pointer after 
>> ABA but you don't synchronize with the newer store that gave you 
>> node2, leaving you to speculatively read stale values through *ctx->hp.
>> (I am assuming here that ctx->hp is essentially an out parameter used 
>> to let the caller know which node got protected).
> 
> The following change should fix it:
> 
>       cmm_barrier();
> -    node2 = uatomic_load(node_p, CMM_RELAXED);    /* Load A */
> +    node2 = rcu_dereference(*node_p);    /* Load A */
> 

I don't think this fixes it, because IIRC rcu_dereference relies on the 
address dependency (which we don't have here) to provide ordering.

I would recommend either:

-    ctx->hp = node;
+    ctx->hp = node2;

which fixes the problem under the perhaps too weak assumption that the 
compiler doesn't use its knowledge that node==node2 to just undo this 
fix, or more strictly,

+    ctx->hp = READ_ONCE(node2);

which I believe makes sure that the value of node2 is used.

Alternatively you could always use an acquire load.


Best wishes,

   jonas


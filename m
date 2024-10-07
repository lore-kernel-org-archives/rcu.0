Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276A1E49E;
	Mon,  7 Oct 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313180; cv=none; b=V/4K3c1i4AqZXbL6v3GpQLewV8j7ktyAK8/wl8FYipNd4QIOrvTm3xbe2k3B7dVjo9PMW1nWxkD3iX4JSDesUiNPnubZdjONifqezoYse0F2CXQrVOqslZpjWvgHeLpKa0Jnudq1KwVeiZsLIawN9ZStlH3x4O9eUVqIf6DNjMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313180; c=relaxed/simple;
	bh=GVIqygVc5ZBokPnIZpVsJ5SY5rgNzhEdxcEXbU/6Hjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkSwUkRoMmTNrNRfZmeWRXzchfISB7leP+MywEm4TrXDPPGr1bPZpJG3zv9uRMstwmyoxh57urw6ZNo8FohU8jkZdpnH1YiBRiT9dT8HV34MvGjYD2t+DWEj/p4UKqD25MCHVh5EoPIRTB+4T3G49kkc25PfRsFKNc/VX2DEezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XMhcj368vz9v7Hk;
	Mon,  7 Oct 2024 22:39:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D44F8140934;
	Mon,  7 Oct 2024 22:59:25 +0800 (CST)
Received: from [10.45.154.49] (unknown [10.45.154.49])
	by APP1 (Coremail) with SMTP id LxC2BwBn+C899wNnLeJjAg--.43995S2;
	Mon, 07 Oct 2024 15:59:25 +0100 (CET)
Message-ID: <b86aac93-d1f7-4716-9283-4a8367b20e48@huaweicloud.com>
Date: Mon, 7 Oct 2024 16:59:06 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
To: David Laight <David.Laight@ACULAB.COM>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 'Alan Stern' <stern@rowland.harvard.edu>
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
 <6ae2461a-e509-4c4d-8959-ae17eb214419@huaweicloud.com>
 <43788527053542e78001820857445e4d@AcuMS.aculab.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <43788527053542e78001820857445e4d@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwBn+C899wNnLeJjAg--.43995S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4fKr47tFyfGryfKr15urg_yoW8Cr1kpF
	W5WanIya1kXrWakF1vq3WUZF90yayftFWUCrn5Kry8Z3s8XFn7AFWayryYya4DCr1fG34j
	vr4jv3sxAF90qFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



Am 10/7/2024 um 3:18 PM schrieb David Laight:
> From: Jonas Oberhauser
>> Sent: 07 October 2024 12:55
>>
>> Am 10/3/2024 um 3:23 PM schrieb Mathieu Desnoyers:
>>> What _does_ work however are the following two approaches:
>>>
>>> 1) Perform the equality check on the original variables, creating
>>> new versions (with OPTIMIZER_HIDE_VAR) of both variables for the
>>> rest of their use, therefore making sure the pointer dereference
>>> are not derived from versions of the variables which were compared
>>> with another pointer. (as suggested by Boqun)
>>
>> This should not be guaranteed to work, because right after the
>> comparison the compiler can do b=a, then it doesn't matter how much you
>> hide afterwards.
>>
>> However it might work if you escape the addresses of a and b first, in
>> which case the compiler will not do b=a anymore, but it might force the
>> compiler to put a and b on the stack, which has some performance impact.
> 
> Nope, as pointed out last week, the compiler can move the 'a == b'
> check to before the OPTIMISER_HID_VAR() and then use the same register
> for both of them.
> 

Since the addresses of a and b have escaped, I don't think it can still 
put them into the same register (or memory location).

Other threads could be temporarily modifying (inside the escape code) or 
concurrently reading (after the escape code) the two variables 
independently.

Something in the direction of

a = ...;
...
b = ...;

escape(&a);
escape(&b);
if (a == b) {
    OPTIMIZER_HIDE_VAR(b);
    *b;
}


Here doing b=a after a==b would (from the point of view of compiler) 
potentially introduce a data race.

As I pointed out earlier, the compiler might be able to prove that it is 
a benign data race though and theoretically still do b=a. But if you 
declare b as volatile on top...

Anyways, the ptr_eq way is much more obvious.

   jonas


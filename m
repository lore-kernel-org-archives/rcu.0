Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D3183098;
	Mon, 30 Sep 2024 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697996; cv=none; b=ODs5wqtqsRILEPrHIN/kYrmKBBQaw69zjCb9bCt10TRO/v/cyggYD+L6HTlEs7iFLN5mRlSCKiHuXIYfxsx1Mjf45kteq9A7TZUo1kFGvbgkCqcVJ7Av2fGnadruAVqxf5LwmMCFLBU+ikttle5JIl6ALTjrgbKeww8YlfAflUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697996; c=relaxed/simple;
	bh=3uZm5F8HdZrf1jSahO+r1HjBDvuoNtC9/fe/8536mZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhuZrUNSwpnj1nB0UoaZJ9HQOlWRvg5Yau5kDQBHCNc5/adwoLTLNzmGgVEzHnh+XxLO/q61GoSIcWFv9wDqC0ARHy9H8/4RYDJcZrCgGU0RcTERdbPrW85TDsI1Qz91frLTYILfJw+/jx0vGRqlx9vZc8Mnz5VZTS+fVDCCmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XHK6Q326Pz9v7Hy;
	Mon, 30 Sep 2024 19:46:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id E46EC14059D;
	Mon, 30 Sep 2024 20:06:30 +0800 (CST)
Received: from [10.81.209.28] (unknown [10.81.209.28])
	by APP2 (Coremail) with SMTP id GxC2BwBXBsc2lPpmpbvyAQ--.6803S2;
	Mon, 30 Sep 2024 13:06:30 +0100 (CET)
Message-ID: <50bd6ecb-c8e3-4043-9040-b2b4ee71fc02@huaweicloud.com>
Date: Mon, 30 Sep 2024 14:06:12 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
To: paulmck@kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, John Stultz <jstultz@google.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
 rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <2091628c-2d96-4492-99d9-0f6a61b08d1d@efficios.com>
 <d2c87672-af75-4210-bd96-d7f38f2f63ac@rowland.harvard.edu>
 <d49f5d9f-559d-449b-b330-9e5a57d9b438@efficios.com>
 <25344f33-b8dc-43fb-a394-529eff03d979@rowland.harvard.edu>
 <f635f9ce-fef4-4a9e-bee1-70dbc24a82ad@huaweicloud.com>
 <973ae617-96a8-456a-a805-af3d61270125@paulmck-laptop>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <973ae617-96a8-456a-a805-af3d61270125@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBXBsc2lPpmpbvyAQ--.6803S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY37kC6x804xWl14x267AKxVWrJVCq3wAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVW8ZVWrXwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 9/30/2024 um 1:04 PM schrieb Paul E. McKenney:
> On Mon, Sep 30, 2024 at 11:42:11AM +0200, Jonas Oberhauser wrote:
>>
>>
>> I also currently don't see any major difference between the constant and
>> register case. The point is that the address is known before loading into b,
>> and hence the compiler + hardware can speculatively load *b before loading
>> into b.
> 
> In theory, true.  In practice, in the register case, you need a little
> more bad luck for the compiler to be able to exploit your mistake.

If there's one thing I've never run out of, then it is bad luck with 
technology.

   jonas


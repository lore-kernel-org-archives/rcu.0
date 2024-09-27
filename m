Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8513AD1C;
	Fri, 27 Sep 2024 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727464359; cv=none; b=CILSoZyAAvZvlW/+pLrgGAfTGsBgwNQPnXS1uP3OjhirPE2KQyNpNDi94ToX0/fJs0tDAgAhrY+tMCcexcid9eFLIwMMgSwGW0o1eq4oB9C3j6OeVxOxc9oeeorTM4aMPPFBaMU+Jj22NwrMn4y/vNi799tiLiT7PSs0cmnTgwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727464359; c=relaxed/simple;
	bh=8wpubwXCGXoVmfAHfIF5StVhRnWB0U7keO4Zg6GWO58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAuYUbZrAU65T0ycj77itkVxgFikXhzEX5c/flkURdoC2rmS5qlTXsgzPfer/miEJEG1TFZv6N8Ev3FL62NvAiKEyqqz5JRbAFNWOJ2RplCPK2RPc04rcbzpgOF6RBCxjMCkuFvIdrUSfTELrRo5hVZH7dlyjxuFsVEMR9Q0YCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XFfZc18S7z9v7Nc;
	Sat, 28 Sep 2024 02:46:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id DD54C1400CA;
	Sat, 28 Sep 2024 03:12:27 +0800 (CST)
Received: from [10.81.203.162] (unknown [10.81.203.162])
	by APP2 (Coremail) with SMTP id GxC2BwAniMiMA_dm8ODFAQ--.41972S2;
	Fri, 27 Sep 2024 20:12:27 +0100 (CET)
Message-ID: <1b04e35c-8994-48d9-907a-966bb4dfabaf@huaweicloud.com>
Date: Fri, 27 Sep 2024 21:12:09 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>, Vlastimil Babka
 <vbabka@suse.cz>, maged.michael@gmail.com,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com>
 <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux>
 <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
 <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com>
 <CAHk-=wgQyXOt_HjDZHNqWMmyvv74xLAcMw88grfp4HkKoS2vLw@mail.gmail.com>
 <7e1c8a5e-c110-414c-8fb2-022eacc2bd4a@efficios.com>
 <CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com>
 <34ec590c-b109-44a0-8bfe-8aafc6e7ad64@efficios.com>
 <CAHk-=wi_hz8Whs2ogRUQEfMBk=OkZ3usmvJkzb5YyEKwqEJBmQ@mail.gmail.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <CAHk-=wi_hz8Whs2ogRUQEfMBk=OkZ3usmvJkzb5YyEKwqEJBmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAniMiMA_dm8ODFAQ--.41972S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYs7kC6x804xWl14x267AKxVWrJVCq3wAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r4a6rW5MxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 9/27/2024 um 8:13 PM schrieb Linus Torvalds:

> Because even hiding the value one from the compiler will mean that it
> can't use the comparison to decide that the originals are equal, even
> if one of them is unhidden.
> 
> No?
> 
>                Linus

I think it depends on which one you hide.

If you do

  z = b;
  hide(z);
  if (a==z) { *b; }

then it will be fine, because it knows a==z but nothing about the 
relation of b with a or z.


But for

  z = a;
  hide(z);
  if (z==b) { *b; }

then it would still know that b == z, and could replace *b with *z 
(which really is *a).


Best wishes,
   jonas




Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5A9443;
	Fri, 27 Sep 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727457448; cv=none; b=pDXyqL3zZbIGzubh9HVxKO/IjPyCS+y+4gZnSnFP8uOgIazoIqZ4TJvgCgHMjKmPP4rWBOKq/NCu9uQSPCmXMcTUJdrWlUVZMgceR8aVHDGqcK9tB9dyf254MgOMG7jXrRxi3gZ3BY5uGLukASx9wedExKzhcJ/U7z3Xvt5WaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727457448; c=relaxed/simple;
	bh=9Pl6bXAtXjhyfWlziszA39Bp4r22pKu2aujIPaMnnVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zoi1BtQnCJGy8wsU0/S02VLcvOK3CknDto5XrmpYcn/3zvngNgeTGT2RQ2kTG1XxWKT1lRGXoCEmJC5vjKp9IWMqd5lXVXtUWlGg2katpWkyhF5ztGuUz04pM8FwvWTn8FRbHP8gc25XJaUBgvRzWuWEt3QhdMhT5asGtkroEJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=fjx/aFpp; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fjx/aFpp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727457444;
	bh=9Pl6bXAtXjhyfWlziszA39Bp4r22pKu2aujIPaMnnVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fjx/aFppwNW8w8vhvtDpCiF5R+jIMtcUVs/0TycezS6PfO7g4K17zRV7o0UkWamr5
	 vgPyDSJnVIn2UCvDU7GH9MdXEUArA53xCUsR3ANZsu9Ipfta/PZy+hupewNXXldJkr
	 Q/TeKkoxv9WjYUMwAfQsHAbf0HnJLAL3bhvSYy4J1ONG99q0n5qXN2kRU4LbH5D8tG
	 a3jE4NxHTySOJ1JuT13o5SYdYdzOcmoGTJ6O/gZeDlq7LoZ7trHhOfE2qUFq+13inS
	 zFbDBuv9sKLqosN++v9s0Rp7DxzDKCtmuKlGVjHzhcCzlSMNXwsyQ0f/hgkfZDzCo5
	 ObmckiIHVU8+Q==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XFcbS44H9z1Q6v;
	Fri, 27 Sep 2024 13:17:24 -0400 (EDT)
Message-ID: <7e1c8a5e-c110-414c-8fb2-022eacc2bd4a@efficios.com>
Date: Fri, 27 Sep 2024 13:15:19 -0400
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
 Boqun Feng <boqun.feng@gmail.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
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
 <ZvP_H_R43bXpmkMS@boqun-archlinux>
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wgQyXOt_HjDZHNqWMmyvv74xLAcMw88grfp4HkKoS2vLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-27 18:44, Linus Torvalds wrote:
> On Thu, 26 Sept 2024 at 18:38, Boqun Feng <boqun.feng@gmail.com> wrote:
>>
>> Note that ADDRESS_EQ() only hide first parameter, so this should be ADDRESS_EQ(b, a).
> 
> Yeah, please stop making things unnecessarily complicated.
> 
> Just use a barrier(). Please. Stop these stupid games until you can
> show why it matters.

The barrier() is ineffective at fixing the issue.
It does not prevent the compiler CSE from losing the
address dependency:

int fct_2_volatile_barriers(void)
{
     int *a, *b;

     do {
         a = READ_ONCE(p);
         asm volatile ("" : : : "memory");
         b = READ_ONCE(p);
     } while (a != b);
     asm volatile ("" : : : "memory");  <----- where you would like your barrier
     return *b;
}

With gcc 14.2 (arm64):

fct_2_volatile_barriers:
         adrp    x0, .LANCHOR0
         add     x0, x0, :lo12:.LANCHOR0
.L2:
         ldr     x1, [x0]    <------ x1 populated by first load.
         ldr     x2, [x0]
         cmp     x1, x2
         bne     .L2
         ldr     w0, [x1]    <------ x1 is used for access which should depend on b.
         ret

On weakly-ordered architectures, this lets CPU speculation
use the result from the first load to speculate
"ldr w0, [x1]" before "ldr x2, [x0]".
Based on the RCU documentation, the control dependency
does not prevent the CPU from speculating loads.

There are a few ways to fix this:

- Compile everything with -fno-cse-follow-jumps.
- Make the compiler unaware of the relationship between the
   address equality and address-dependent use of b. This can
   be done either using ADDRESS_EQ() or asm goto.

I prefer ADDRESS_EQ() because it is arch-agnostic. I don't
care that it adds one more register movement instruction.

> And by "why it matters" I mean "major difference in code generation",
> not some "it uses one more register and has to spill" kind of small
> detail.

Why it matters is because gcc generates code that does not
preserve address dependency of the second READ_ONCE().

> At this point, I'm not even convinced the whole hazard pointer
> approach makes sense. And you're not helping by making it more
> complicated than it needs to be.

I'm preparing a small series that aims to show how a minimal
hazard pointer implementation can help improve common scenarios:

- Guarantee object existence on pointer dereference to increment
   a reference count:
   - replace locking used for that purpose in drivers (e.g. usb),
   - replace RCU + inc_not_zero pattern,
- rtmutex: I suspect we can improve situations where locks need
   to be taken in reverse dependency chain order by guaranteeing
   existence of first and second locks in traversal order,
   allowing them to be locked in the correct order (which is
   reverse from traversal order) rather than try-lock+retry on
   nested lock. This can be done with hazard pointers without
   requiring object reclaim to be delayed by an RCU grace period.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


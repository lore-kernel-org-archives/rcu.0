Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337301;
	b=LZxdPnc9OXWxtp3m0TbQ1ivCTHKF5sXdcm6NFGtOfS0SP9o3+qEDiFtzIZKLl1vDYhA9
	 QPLsaH0x8bSoTgOeZHHlyA9N07redPZsfyf7RR1SGSO70g8vU/XdQgYE96Royf3f/G4pr
	 NUPa/mUvmXiOVpyA6o4GLMN8ReAFHOCeZ/zWQ18/q84qJbq7b+HNXyZTABO5hdE/0+ewY
	 EYNgCgWK7LNm72BevlMvp+HUQwvsQYPTq52EFXp5EDqI3fAWXpLqNV84Df3VjAkDwLHGQ
	 Wj8qo4tAMrS64RuYp6bY119PdjFuYfMIjo8uL9yjhuqmDa56Pcy+EX8oqWLRf9yDkEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337301;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ANGsAW3ddISCEyK4d//HKeoYe5zuJzrn5kEwLtvmkDM=;
	b=vo26WBOty+WuEz9TkOlTt+haZ4F97jaXgK7QEpTpQYZyPrEl2wL7I5UcivdwyOndowoi
	 Q0UqYdclGAqLyXR/K6ySnsKbXw9p/8PNFEvLrAxOh6JS3KmH87mZOZMXVDcpFGzQmd57P
	 dRRr/fKbOPM5jYUVyNnY6XKjhlOldWYF+MH+Agmd0CPdxWuJMtMmfOoKwPHtrPEr3CJ/s
	 l0aHUuuCCuAXdhEmtw1jyQjPT5Usizk37UlSRQIL/6oMic7rIbZ5FPvXw+WQWXQGiW0oC
	 JqTczl5ANilX3mrl+QpJXXqRAivjCFuUG7UyWk5imdGg3SRj77xjf/XmeMBV0u4buRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VCkwheyk;
	arc=none smtp.remote-ip=91.218.175.114
Received: from mta0.migadu.com (out-114.mta0.migadu.com [91.218.175.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05175606A326
	for <rcu@vger.kernel.org>; Tue, 10 Nov 2026 19:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05175606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VCkwheyk
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n6jhI9QzIIOuQuMEhfxCfvU9Cq83yhTDFf2khKzfCyE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794337297; v=1; x=1794942097;
 b=VCkwheyk2MSmuDtSZjjN4wklntbwI5Gk74s1ue9+wDMxbdtVzBivQZxQkFrgqI94uL+8VD3w
 xw/RdhRepjFpf/P9ELNb7RZnXQi0EUtFQCzEsUFsDo7ewm5MFmgUJ3xFFc/IT1Bz4pUlPmRU1KH
 UQWZqKtxBaTO4sKbqQeTXU+4=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9b3cd5053f99a7d5;
	Tue, 10 Nov 2026 19:01:36 +0000
X-Mizu-Trace-ID: 9b3cd5053f99a7d5
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 19:01:36 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: paulmck@kernel.org
CC: boqun@kernel.org, christophe.jaillet@wanadoo.fr, dan@cryspen.com,
 dave@stgolabs.net, frederic@kernel.org, jiangshanlai@gmail.com,
 joelagnelf@nvidia.com, josh@joshtriplett.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
 qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org,
 urezki@gmail.com
Subject: Re: [PATCH] rcuscale: Constify struct rcu_scale_ops
In-Reply-To: <b6f19ac5-1336-43f4-8bb3-a891984adb19@paulmck-laptop>
Message-ID: <CE48A881-9AAF-467F-A0FF-C8F853643888@linux.dev>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 10 November 2026 18:34:00 GMT, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Tue, Nov 10, 2026 at 08:06:59AM +0300, Dan Carpenter wrote:
>> On Mon, Nov 09, 2026 at 10:44:16AM -0800, Paul E. McKenney wrote:
>> > On Mon, Nov 09, 2026 at 06:32:15PM +0100, Christophe JAILLET wrote:
>> > > Le 09/11/2026 à 00:06, Joel Fernandes a écrit :
>> > > > On Sat, Nov 07, 2026 at 10:02:25PM +0100, Christophe JAILLET
>wrote:
>> > > > > 'struct rcu_scale_ops' is not modified in this driver.
>> > > > > 
>> > > > > Constifying these structures moves some data to a read-only
>section, so
>> > > > > increases overall security, especially when the structure holds
>some
>> > > > > function pointers.
>> > > > > 
>> > > > > On a x86_64, with allmodconfig:
>> > > > > Before:
>> > > > > ======
>> > > > >     text	   data	    bss	    dec	    hex	filename
>> > > > >    45585	  24946	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
>> > > > > 
>> > > > > After:
>> > > > > =====
>> > > > >     text	   data	    bss	    dec	    hex	filename
>> > > > >    46545	  23986	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
>> > > > > 
>> > > > > Signed-off-by: Christophe JAILLET
><christophe.jaillet@wanadoo.fr>
>> > > > > ---
>> > > > > Compile tested only.
>> > > > 
>> > > > rcuscale is a test kernel module, is it worth adding boilerplate
>for
>> > > > non-production code sighting security reasons?
>> > > 
>> > > Oups, now I better understand Bradley Morgan comments.
>> > > 
>> > > I didn't notice it was a test module.
>> > > My patch makes no more sense, as it is not hardening runtime, so
>feel free
>> > > to just drop it.
>> > > 
>> > > Sorry for the noise and not seeing it by myself.
>> > 
>> > Although the header comment does say "Read-Copy Update module-based
>> > scalability-test facility", maybe there is something that should be
>> > done to more clearly mark code that is not to be used in production.
>> > And maybe to inform the LLM review bots of this.
>> > 
>> > But this is bigger than just RCU.
>> 
>> Christophe has been constify things for years and years.  There is
>> an argument to be made that it's just the right thing to do whether
>> this is test code or not.  Someone might copy and paste it, for
>> example.
>> 
>> Of course, everyone is overloaded with AI.  I feel like normal cleanup
>> patches are more likely to get NAKed because everyone is just totally
>> overwhelmed.
>
>Fair enough, though rcutorture.c (in the same directory as rcuscale.c)
>*does* write to its counterpart to this structure.  The point being that
>this is an optimization-like thing rather than a prohibition-like thing.
>
>So we might want some way to differentiate between these two cases.

Well, I'm not saying "no this shouldn't happen", but the benefits are
negligible ISH. Well, Paul, what do you reckon? I'm not fussed, just a bit
"ehhh..."

>
>							Thanx, Paul
>
>

--- Thanks!

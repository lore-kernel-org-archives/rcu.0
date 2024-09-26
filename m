Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95571547E4
	for <rcu@vger.kernel.org>; Thu, 26 Sep 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342116; cv=none; b=mVC5St1usETCfCZEn/5Cgm7JdHanwd/W+XhcEy8Zgs+IyU1uMAtP07rYRi2AC+2gBY31oCP31vM2J2Zpfd3x8Ebqxv8/erAtX3+5QQqgVD17DXhUi5WYNBW/NJEoRXofjSOJjMM2D41px9cepH2Gtmyjcl9CcwZ3XamWU4J7RKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342116; c=relaxed/simple;
	bh=Hz/X1hviwTQFhUXw0cjQaNiwPacVZ8SXLv2utuSlzNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OE3VbquMF6c6QZf8icAo75z4ReXP5jy2/spb0htwjHd7YzJrDNNe68vhv3AWLZdXraHxjQG19p0Oi308h10zneyvoWW0veKBlVdnV4ImBQPlgjvSBBZ72LcYuX5jrGB30Q6mt/a4KjFVofFXcTsj5IQlu6XndE4te2z49muCiEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=TynLWPfi; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="TynLWPfi"
Received: from localhost (unknown [10.0.8.2])
	by mail.tkos.co.il (Postfix) with ESMTP id 50ACA440F85;
	Thu, 26 Sep 2024 12:03:08 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1727341388;
	bh=Hz/X1hviwTQFhUXw0cjQaNiwPacVZ8SXLv2utuSlzNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TynLWPfitYbbip5d1wBgxJo+7uIL892/wSdZXFraNWTVYgTS5Kbk70d/g5V2tqr8G
	 in4UYHjMevfe0HspHQatlOmlOxaJ7zga1ngKiZR5/4LDhUZ6yZZTP9ui8V0AQeQinn
	 KNjW9SszdjGfCzLLXbWoZB6cOpIiksUeS1DtYauPEhNKs0pDJ5mpV9fOymJRtHxGJ4
	 mmiwkQoLQqBLpj98HRXcmLAbb5TeMqrg2hfwEfbR5yRkF4aQn1yc+A2mF1n10q6JtZ
	 FGOOY6kxccPs70HYV2fsDEX8XKWcAAC1Tyaq+YihCsT3UOBdby4zkBB7BfBu4UbgTU
	 ZsIF313WryWvw==
From: Baruch Siach <baruch@tkos.co.il>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,  Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>,  Joel Fernandes <joel@joelfernandes.org>,
  Josh Triplett <josh@joshtriplett.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  Uladzislau Rezki <urezki@gmail.com>,  Steven
 Rostedt <rostedt@goodmis.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Lai Jiangshan <jiangshanlai@gmail.com>,
  Zqiang <qiang.zhang1211@gmail.com>,  rcu@vger.kernel.org
Subject: Re: [PATCH] doc: rcu: update printed dynticks counter bits
In-Reply-To: <e1af4a94-577a-4fe4-be4f-e4c7b835aab7@paulmck-laptop> (Paul
	E. McKenney's message of "Tue, 20 Aug 2024 11:47:22 -0700")
References: <5dd8782f70c3b2367ae3c7d9016eb8fb32c76b49.1723969097.git.baruch@tkos.co.il>
	<e1af4a94-577a-4fe4-be4f-e4c7b835aab7@paulmck-laptop>
Date: Thu, 26 Sep 2024 12:05:38 +0300
Message-ID: <87cykq23a5.fsf@tarshish>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Paul,

On Tue, Aug 20 2024, Paul E. McKenney wrote:
> On Sun, Aug 18, 2024 at 11:18:17AM +0300, Baruch Siach wrote:
>> The stall warning prints 16 bits since commit 171476775d32
>> ("context_tracking: Convert state to atomic_t").
>> 
>> Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t")
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>
> Good eyes!
>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

I remember seeing this patch queued in one of the rcu git trees, but I
can't find it anymore. I don't see it in Linus' tree either.

Thanks,
baruch

>>  Documentation/RCU/stallwarn.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
>> index ca7b7cd806a1..30080ff6f406 100644
>> --- a/Documentation/RCU/stallwarn.rst
>> +++ b/Documentation/RCU/stallwarn.rst
>> @@ -249,7 +249,7 @@ ticks this GP)" indicates that this CPU has not taken any scheduling-clock
>>  interrupts during the current stalled grace period.
>>  
>>  The "idle=" portion of the message prints the dyntick-idle state.
>> -The hex number before the first "/" is the low-order 12 bits of the
>> +The hex number before the first "/" is the low-order 16 bits of the
>>  dynticks counter, which will have an even-numbered value if the CPU
>>  is in dyntick-idle mode and an odd-numbered value otherwise.  The hex
>>  number between the two "/"s is the value of the nesting, which will be
>> -- 
>> 2.43.0
>> 

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

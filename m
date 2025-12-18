Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE80335572
	for <rcu@vger.kernel.org>; Thu, 18 Dec 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079855; cv=none; b=LfChKPAy0Zb+zBYuzI2HomGSpPavwoKBS6xD+7zS2hp8/7wx3IHVugHbkY3IqdhRUvjSl1aKdMWWN8uOzXtGv8nDyQfqw6W47PuEbw1xMllM0j4T3BKXZc5+RTgwma/pe5RSCIOip4YQXyekP/t8y5osxwEMF1sHHwnnA8ydTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079855; c=relaxed/simple;
	bh=wETgaVi/4Srcrvn11NsykVRNrUKwSV1mN9QfsLJ8b7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkwnJn6FqD4z70C0cGO0dm3XSngzYHD3KCLNg+PdzcG1BEAArEiEGejEbuZFBhZva61WW50l+Qs/+AvUVhc6kRlb6h2P/ZTW2dmvyaAXAiPB01TU6nRV3ALBAGdxoGVxPT0WfIHHoiz0QbUdys7Cb21SzJ097gqwNkdj4vLc2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqevqybE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqevqybE"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79d0a0537bso120354766b.2
        for <rcu@vger.kernel.org>; Thu, 18 Dec 2025 09:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766079851; x=1766684651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAT4NIB50wSSQJ2eRS7sx9I/iK0vGJNZ4n3UlMbS9UY=;
        b=KqevqybEKtM1j48sXTSgKJlr7+Vb8lvKU7j8aRYmCWPoNI5FRXUcXsBligWowYVkAR
         ivpPQZxA3j2Ft0E7lHXV7DnHFHQ1tYM/i6nTF/ocanaJn/nvIZlgz9HX0Dmny340L0Cp
         AJfgNSa+N5R1TXvPvtuOMA0/K2jdNhyzQA1jUUVaov/R0hUfMTFH0FmsczMZvSOmpzD+
         Wai1NJ8kHb+84RBX7wplmFyh+qflzEw8xZDbQzufVEfWZswk1L72CKcSdvVRhRXOxpeD
         Y4Wj/gMcPuhH0CCMNM2zdMs79a6rkuENg3eLnY6xaleZCfQxfUWEtfA+BBgXKA0TZmg9
         CEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766079851; x=1766684651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CAT4NIB50wSSQJ2eRS7sx9I/iK0vGJNZ4n3UlMbS9UY=;
        b=IfsGzQ7fa+dDtRaklN6TwL5z+p7E0RbY4ZBsYn2VcebYcvJG+lSogJE2mGR5VcnKTY
         9aiFfKCMJx3kvoE5yFVMcOnY4jIRKsFSxelbIOBKUcya4LNCw1E7rWTZt/djdB067P0r
         WphvzFf5lbbiyQ6evvmo8FTOVbLVV/0b9MgYJd22jHYEuDst3lGyaBP7poduwUCfJ6uY
         XMODJMPvYPYuczjIc48ipBcCQUCTwoImAbJ4RJreEBx644KlXZsTH9u1iH3OBE+aVNNm
         BCBw4YqsrAlTdTvwwx3zpK/X2lFTjPIaNSo/96jXhk8erdHVVvpcNAgg2NzTQp/K6BeP
         H82A==
X-Forwarded-Encrypted: i=1; AJvYcCVHfeIphs7Aw+tMBfi2T2qbJre05nfT51wA61Ol7QejoaXwWeLdG1FSUrK1pdhQpITa0Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQegJOoih23pLek3VFjekb36bOwDvEB8sNKPUjUi9amroEShnj
	OHiLnx+05+ioAuQVVkYhG44UhusaFsFpx8UFRF6FbaVIYzjiAtqRcsf3r58mXw==
X-Gm-Gg: AY/fxX5SORfJrihTPs00qjOcw2Dk+PH8h/PwgC9cnc2BuL0g/pYIaDjtBxegRcLofN7
	PAizolNbASEM+Qg/BzIMZ5drXMBZKruaoWTazGiebQI/WJTcfm82D5LNGUI3/LGV3YVmo7cITfd
	JUOc5W+bMNsiF9RUEQXJDhcZwVLyBP4v4Z10VHr8oQ8Z+cSninWt4BtTXqAeVZ/sb5sde62tdGC
	cDQDrslpkhY6SSFwBR6Rc30HEH3gejRGEHw0UOxPRyEvVZ6gh5nxM5S06yYBuBv95K/flD3unu0
	CNX4FVPq2MeKxQ2lqlhm2trhdwHjDdywwxDazh2AnleqTGRpr9bXxwC5CgB3S6lmBhtn9XDur26
	yx8Mc6R4BioV2fGtBoXbkiu+3F/2V2+rFpQrK8w/oVUUb+ijVXAwWXRkoeUHO/mjrMCSqOvMsB5
	DqEn4Kj1uWvrKIS38syL5O5UShEsCvtJSTU0XBRvB2j87QMvFhYqUQ
X-Google-Smtp-Source: AGHT+IEX3LAgYnT5Lo93smJLzWDPMc1uQ4Aj1gMjYO0ty7+7jdOdeZ5GXQKimSTh9jzRGuiit8vdow==
X-Received: by 2002:a05:600d:1b:b0:477:a219:cdb7 with SMTP id 5b1f17b1804b1-47a8fa81e14mr202186375e9.0.1766073295465;
        Thu, 18 Dec 2025 07:54:55 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b749esm48092275e9.14.2025.12.18.07.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:54:55 -0800 (PST)
Date: Thu, 18 Dec 2025 15:54:52 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Will Deacon <will@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, John Stultz
 <jstultz@google.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Frederic Weisbecker <frederic@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar
 <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil
 Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik
 <mjguzik@gmail.com>, Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev, Gary Guo
 <gary@garyguo.net>, Nikita Popov <github@npopov.com>, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v4 1/4] compiler.h: Introduce ptr_eq() to preserve
 address dependency
Message-ID: <20251218155452.6ae47481@pumpkin>
In-Reply-To: <cb55e583-395f-4b83-925f-c341c95903c1@efficios.com>
References: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
	<20251218014531.3793471-2-mathieu.desnoyers@efficios.com>
	<20251218090313.33923750@pumpkin>
	<cb55e583-395f-4b83-925f-c341c95903c1@efficios.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 08:51:02 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2025-12-18 04:03, David Laight wrote:
> [...]
> >> + *
> >> + * The compiler barrier() is ineffective at fixing this issue. It does
> >> + * not prevent the compiler CSE from losing the address dependency:
> >> + *
> >> + * int fct_2_volatile_barriers(void)
> >> + * {
> >> + *     int *a, *b;
> >> + *
> >> + *     do {
> >> + *         a = READ_ONCE(p);
> >> + *         asm volatile ("" : : : "memory");
> >> + *         b = READ_ONCE(p);
> >> + *     } while (a != b);
> >> + *     asm volatile ("" : : : "memory");  <-- barrier()
> >> + *     return *b;
> >> + * }
> >> + *
> >> + * With gcc 14.2 (arm64):
> >> + *
> >> + * fct_2_volatile_barriers:
> >> + *         adrp    x0, .LANCHOR0
> >> + *         add     x0, x0, :lo12:.LANCHOR0
> >> + * .L2:
> >> + *         ldr     x1, [x0]  <-- x1 populated by first load.
> >> + *         ldr     x2, [x0]
> >> + *         cmp     x1, x2
> >> + *         bne     .L2
> >> + *         ldr     w0, [x1]  <-- x1 is used for access which should depend on b.
> >> + *         ret
> >> + *
> >> + * On weakly-ordered architectures, this lets CPU speculation use the
> >> + * result from the first load to speculate "ldr w0, [x1]" before
> >> + * "ldr x2, [x0]".
> >> + * Based on the RCU documentation, the control dependency does not
> >> + * prevent the CPU from speculating loads.  
> > 
> > I'm not sure that example (of something that doesn't work) is really necessary.
> > The simple example of, given:
> > 	return a == b ? *a : 0;
> > the generated code might speculatively dereference 'b' (not a) before returning
> > zero when the pointers are different.  
> 
> In the past discussion that led to this new API, AFAIU, Linus made it
> clear that this counter example needs to be in a comment:

I might remember that...

But if you read the proposed comment it starts looking like an example.
It is also very long for the file it is in - even if clearly marked as why
the same effect can't be achieved with barrier().
Maybe the long gory comment belongs in the rst file?

I do wonder if some places need this:
#define OPTIMISER_HIDE_VAL(x) ({ auto _x = x; OPTIMISER_HIDE_VAR(_x); _x; })

Then you could do:
#define ptr_eq(x, y) (OPTIMISER_HIDE_VAL(x) == OPTIMISER_HIDE_VAL(y))
which includes the check that the pointers are the same type.

But it would be more generally useful for hiding constants from the optimiser.

	David

> 
> https://lore.kernel.org/lkml/CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com/
> 
> This counter-example is what convinced him that this addresses a real
> issue.
> 
> Thanks,
> 
> Mathieu
> 
> 


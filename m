Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88CD2E7653
	for <rcu@vger.kernel.org>; Wed, 29 Oct 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732599; cv=none; b=cMd+DSW/c8DUEqE0hEXRRTwHnLuwFmzVDBwuYqi5TXfIS046+IHA7XN3J6fc6belhKOwb37acPHOPuHv83YFDJ/LQ6Zly6iDjK1I5er65txZ/npHIKA3hpAtOc9OvRRZk8Hn1pj/OnWjB2LjJVUfOSI1w2dF0n0wXzkJgaym/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732599; c=relaxed/simple;
	bh=Q+xHtZ6LCUfDVi4zhyxd0pSM1tPgfsgGrZ8Ux4ie/xI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c/lPO4VHzZ+eoqykjHZOc0S1ZN+PIyAA9I5Ch85m+sB1mNIo7eaY+Re4HmqMI2SA/+unt5kQlAKt6ofh0iodu9Kfau54nkphXGhGQCBMR68bCw5If9r8fDpisa4Q3kKdg1bV1Q5IkuIn2H9uIrDBdUzjU5xZsnZbZVAV8QKsa2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPP8ynQv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPP8ynQv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761732596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7va99Zg9nu4+XxtsT3y+i0Qg89ua4ByIHfysL3F+F4=;
	b=IPP8ynQvbtq6k1lnqauxbiTXA59rLfn3RSipFQoWZM+HvMUL795+An+okOyCwnyLNWXUNI
	kzAq/5CXJOuu03dMIzClqV4Hmj2Ql1/Ne5zIDxRZeEsiuzk+p7HxIt5nl3EhY5f+CrzDD0
	LT6d9GrPLN9VYoIASgyCJNwpbKVIm9k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-SeMJ3SQ-Pr-2b03FpjDlBA-1; Wed, 29 Oct 2025 06:09:55 -0400
X-MC-Unique: SeMJ3SQ-Pr-2b03FpjDlBA-1
X-Mimecast-MFC-AGG-ID: SeMJ3SQ-Pr-2b03FpjDlBA_1761732594
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4270a273b6eso5370457f8f.0
        for <rcu@vger.kernel.org>; Wed, 29 Oct 2025 03:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732594; x=1762337394;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7va99Zg9nu4+XxtsT3y+i0Qg89ua4ByIHfysL3F+F4=;
        b=rvWUkPyBQvy8Q8g0zKuQYp+x0xShGmLgT2j5wY6RgWQGwxxXHqWDVeP2qftMFkfye9
         p/yDU4l4X/chlbJXlDdHtqQReRMOhRQ6YyNAgHRifmvfqRrZM6slW/ep59qB/SztoYsf
         fJe4rs4ZsRyJgtL8rB5cvhREdfek6Aa5X5VLIvY/f9gJJXiijdTnX+j/GnVnq+Ydc9Yl
         ZUtAXXApm1m5pT4PshO2NcV6b2M2ui4GEaGQRYZeNIWFxHg2TN2zne357YXufjC0NRos
         wi+kaBG30aHl1WUnVfcmdXl+VhMYEL66p1coFUr/lrBxhImQFPz3Rdsc8oLATjrdn9ZI
         sM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyTVwNvoBRxKwLjpgojQ/yivlmkAmFMD80+1Qmiil3oUeJVTCltoKdZNr7cOqq78gfs9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Y5H+v119t9FYNKNo1kxF0lk8Ku6ruQxCekLTeI7XnC1CbXps
	iXvtqnthzbehmmTSUki627s7Gm/svywtOnjGE0wgHz2DkVBg9TIHrL05q4mmBolnW/BRHOg2LgQ
	zmfPa1gDmkEDpPUXQu1waclKSA6guFyEa7zJVKVTt+QLQgSXBaRY+2A==
X-Gm-Gg: ASbGncuwB+BWpuCURxHbMt7mUrnicYzwgIY08nNFWcZaLqt8N+mps/CUxKyPFeVa8gL
	3QODaUuSmBfvRWf3UEesPTBqNNPgcK1yz1fLkV0Ld+97vgCza/I9k2OBPsCTGl6OFfIcSMOKnl2
	HbXiaVS7DPLslBMiK6Ocu9Xd2DxJjlJ04gbNydqp5Zo5EK3uIWCdHUNMDc31OOhH/9RHL13O7QX
	IPRAPFM0pHelVYG6FWA4YOdOBQYGxvR4UYutoqaSzWWPGvXQNBnwXHw1u3KqXXeLv9yoIubCx3B
	X39JRTsOqY17ZmnTt/2qKk/he44sjGxVnrsBquDnZpDjIsRtSiiY9QNYs8QPbtr7wAEC6MC212m
	/WRW+beXkupGGhyA41vrJJzQlGS1XLDPYuwkro+UOUP5lRXn1jPoJLDWFD1dj
X-Received: by 2002:a05:6000:2089:b0:428:4354:aa43 with SMTP id ffacd0b85a97d-429aef83083mr1733937f8f.18.1761732594351;
        Wed, 29 Oct 2025 03:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMwZOd1Sm4LKIO70Dn8iCGAQm9z32hncQVtTx+dFITCY/jcrLahS/V2gOWr58H4oqqEmvh5w==
X-Received: by 2002:a05:6000:2089:b0:428:4354:aa43 with SMTP id ffacd0b85a97d-429aef83083mr1733872f8f.18.1761732593822;
        Wed, 29 Oct 2025 03:09:53 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952e3201sm25467518f8f.47.2025.10.29.03.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:09:52 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Nicolas
 Saenz Julienne <nsaenzju@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 "David S. Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 23/29] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <aQDMfu0tzecFzoGr@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-24-vschneid@redhat.com>
 <aQDMfu0tzecFzoGr@localhost.localdomain>
Date: Wed, 29 Oct 2025 11:09:50 +0100
Message-ID: <xhsmh5xbyqas1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/10/25 15:00, Frederic Weisbecker wrote:
> Le Fri, Oct 10, 2025 at 05:38:33PM +0200, Valentin Schneider a =C3=A9crit=
 :
>> +	old =3D atomic_read(&ct->state);
>> +
>> +	/*
>> +	 * The work bit must only be set if the target CPU is not executing
>> +	 * in kernelspace.
>> +	 * CT_RCU_WATCHING is used as a proxy for that - if the bit is set, we
>> +	 * know for sure the CPU is executing in the kernel whether that be in
>> +	 * NMI, IRQ or process context.
>> +	 * Set CT_RCU_WATCHING here and let the cmpxchg do the check for us;
>> +	 * the state could change between the atomic_read() and the cmpxchg().
>> +	 */
>> +	old |=3D CT_RCU_WATCHING;
>
> Most of the time, the task should be either idle or in userspace. I'm sti=
ll not
> sure why you start with a bet that the CPU is in the kernel with RCU watc=
hing.
>

Right I think I got that the wrong way around when I switched to using
CT_RCU_WATCHING vs CT_STATE_KERNEL. That wants to be

  old &=3D ~CT_RCU_WATCHING;

i.e. bet the CPU is NOHZ-idle, if it's not the cmpxchg fails and we don't
store the work bit.

>> +	/*
>> +	 * Try setting the work until either
>> +	 * - the target CPU has entered kernelspace
>> +	 * - the work has been set
>> +	 */
>> +	do {
>> +		ret =3D atomic_try_cmpxchg(&ct->state, &old, old | (work << CT_WORK_S=
TART));
>> +	} while (!ret && !(old & CT_RCU_WATCHING));
>
> So this applies blindly to idle as well, right? It should work but note t=
hat
> idle entry code before RCU watches is also fragile.
>

Yeah I remember losing some hair trying to grok the idle entry situation;
we could keep this purely NOHZ_FULL and have the deferral condition be:

  (ct->state & CT_STATE_USER) && !(ct->state & CT_RCU_WATCHING)


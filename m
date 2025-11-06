Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9DD326D53
	for <rcu@vger.kernel.org>; Thu,  6 Nov 2025 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423364; cv=none; b=n52ZqTSZEJkzpBQ999dYs4lhQ7Qk6oTef/4OOerODPUgMOse+Y+JPl17jyBHFfJCisCo7fXjzm56IGo2dILjHD8iXaJLDdxAyCd618uPP6/VEeTgKR3aGWeRjlml0FKDwD5r81Tx9zMzAOXSAEoSi6U+5O2AX5f3EunmG/luZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423364; c=relaxed/simple;
	bh=xATGLdNYOx8U8sS3eIxpE+Pn5qkR1x0EJzj34ZYwqrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u33smp3gN53Zyi0a86+r06GyaoBs/fh9G4YzGSemiD/mpI2WRA8Wmw/7EomWfVaXq+9drZb2ODQAEun5PYO9hvB2YWcXS0q+17QovCL6S3A3t8dsfOz6pjhIYzE4KidGaSdXL+xzoHwHEr2zTWivSJ5HVaOSjT7FBKiYCffVxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PaFMHKnn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDV+kyPI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaFMHKnn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDV+kyPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762423359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tvrt5C8X1gp1kp6b+KY8cbLTeVcvbbT6G6kNQJkblK8=;
	b=PaFMHKnn0YJn/wlHKrQjf308ekD3Ck8aRJluiLHCZQkM4LmWEieQA9hQpoFQFN0cGUlgiJ
	YvM+GQliOByVnIJopQ0GqsFr3DGkFD3dfTnlK0ljkgqhb/PMxljparmN1Mx2TRZ5mlPGY6
	7eSbm3qHoGhBu3KdquSBUp4Jm6U20bg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-WWdviEHKMourHCOH6INUTg-1; Thu, 06 Nov 2025 05:02:38 -0500
X-MC-Unique: WWdviEHKMourHCOH6INUTg-1
X-Mimecast-MFC-AGG-ID: WWdviEHKMourHCOH6INUTg_1762423357
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c95fdba8so465028f8f.0
        for <rcu@vger.kernel.org>; Thu, 06 Nov 2025 02:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762423357; x=1763028157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tvrt5C8X1gp1kp6b+KY8cbLTeVcvbbT6G6kNQJkblK8=;
        b=fDV+kyPIWOZfvyvB4fvNNP3qKM4dt1XMN5Jr18h6Z+JbWOUEJj6M+7/HeJY7s+IWFZ
         JwK+Tdb9K25EzUuDCP7a4R9zQiTwUAamqF+CNURtGsZ6kJX27IqR0MtaOxy9O+AWXnu2
         ayEnn2wvuIJajTFn22ajCQe1ixb4H5OzguXh9ChUM4bwkziuMsKyffXMyJCv9RJf0UJ4
         FLK3ESsKRxhBZlZ2lS7H/KqShhShdCRI4TwbebF2dzBFsn3+O+OdYHo/sLcHCc83sW74
         iG00Gq5LjnqY23vgH/oNFKryhHu1BwhOZQArTyjMVORbHgwAm5/4unsJY6F2jjlTIdzm
         0EXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423357; x=1763028157;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tvrt5C8X1gp1kp6b+KY8cbLTeVcvbbT6G6kNQJkblK8=;
        b=sTojOdMVjJ1FDr94jDx3kS1OG96eVS4NNCopeIKq5TQqCCNRiXrWx47a7jzVaSbmet
         mAAQ44L/jBCn3lcRXOlUjS9PW82hm+b6Sbrjc5NX9ljys86mSLW0IxsS4H7ja8meAokx
         5WzQw1oIFc13jMat0DIbP8wjMOpvhaZyiFe7AJjVc/nUlOEuP6NCU5EFMseeNyBt+5Lf
         Y9R7VBRbE+OlhDVfqNFmL/ETbp29MRsYeQCzf68CBYAKVhin6W01S2mKi9oTDE0rdG/O
         m+NlQrO6RwPhHTkRZmYtgBrdO2QOcsUq2F5KI5z+v0f/yXqw2bSmCiXfapdrGo0qg1vJ
         kl0w==
X-Forwarded-Encrypted: i=1; AJvYcCUlRj3QW62xppLxiyGGcrFxyx0CMd7qB9nOiSQ52zeUpc4Z41adLQXoALz7ljsAjLuaHpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQL7h0d9ca099AmDbhyv1GmxzyI/ay6W7uUjJMx6O4MAfkLJ6
	poPCIq1N3B7cQUNQT9lJmCRFZg8Qh1cBBiyOzhxB6NWzcW6I7UeRi9kZROnj9hs4FkoQ6BsTwuc
	RgkayBapWO3nJhf08nuiWq3EKlCj1FLCm4YCgwa+EvcjDPCcmQqDvKQ==
X-Gm-Gg: ASbGncvNAyRXW9RujvQIsKBx8cOTzpLGa6wL3saxIU3OEyUVZZ8JWp8IpML/QJBZ0oJ
	2cB+G4aBlH//hWd6HZVvES/iWhEUXEWOdEcPLx9e0Zq+Ld03npRyjXPMWM6VRmst7pJ8QqJ6KM7
	oL2NR4hAIAlG+4GsAUtyayxneVfaPArWEjPdu7mRVTUtm7jZ3THgElqbXuJ1V+RoUir9BmD5cKt
	ydfL9jJat8F3xtEXna61paz3pZTR/xl6LXNUXMD3UVstu0x9clnm+Uadz9Qget7bdfC90VcuRta
	7kAWcXBZ3rd/eZp4CJFPY3r4oVS15CWGMEIBvcsidmzAgSLYUWHcu5tYQm6qMg/oPmk/9wB1jQ0
	LyEGZFpl4xok7PT9r4G/g7dollsU5ljNkTZK6c8024W++/RELrh33ooQ1iyVN
X-Received: by 2002:a05:6000:2007:b0:429:bd09:e7ce with SMTP id ffacd0b85a97d-429e32e3751mr5572184f8f.18.1762423357261;
        Thu, 06 Nov 2025 02:02:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFeAmOLmzeYzGPgujTP1e064ll50Q3Ih/Pj2s9y519WV4ZUw6Tz0GJFNvPvZOTYQG+myOLaw==
X-Received: by 2002:a05:6000:2007:b0:429:bd09:e7ce with SMTP id ffacd0b85a97d-429e32e3751mr5572131f8f.18.1762423356748;
        Thu, 06 Nov 2025 02:02:36 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb477203sm4112751f8f.29.2025.11.06.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:02:36 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rcu@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann
 <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel
 <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, "David S.
 Miller" <davem@davemloft.net>, Neeraj Upadhyay
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
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <aQuNdOEmPYkI03my@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aQDuY3rgOK-L8D04@localhost.localdomain>
 <xhsmhzf9aov51.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQJLpSYz3jdazzdb@localhost.localdomain>
 <xhsmh8qgk5txe.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQuNdOEmPYkI03my@localhost.localdomain>
Date: Thu, 06 Nov 2025 11:02:34 +0100
Message-ID: <xhsmh5xbn5vid.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/11/25 18:46, Frederic Weisbecker wrote:
> Le Wed, Nov 05, 2025 at 05:24:29PM +0100, Valentin Schneider a =C3=A9crit=
 :
>> On 29/10/25 18:15, Frederic Weisbecker wrote:
>> > Le Wed, Oct 29, 2025 at 11:32:58AM +0100, Valentin Schneider a =C3=A9c=
rit :
>> >> I need to have a think about that one; one pain point I see is the co=
ntext
>> >> tracking work has to be NMI safe since e.g. an NMI can take us out of
>> >> userspace. Another is that NOHZ-full CPUs need to be special cased in=
 the
>> >> stop machine queueing / completion.
>> >>
>> >> /me goes fetch a new notebook
>> >
>> > Something like the below (untested) ?
>> >
>>
>> Some minor nits below but otherwise that looks promising.
>>
>> One problem I'm having however is reasoning about the danger zone; what
>> forbidden actions could a NO_HZ_FULL CPU take when entering the kernel
>> while take_cpu_down() is happening?
>>
>> I'm actually not familiar with why we actually use stop_machine() for CPU
>> hotplug; I see things like CPUHP_AP_SMPCFD_DYING::smpcfd_dying_cpu() or
>> CPUHP_AP_TICK_DYING::tick_cpu_dying() expect other CPUs to be patiently
>> spinning in multi_cpu_stop(), and I *think* nothing in the entry code up=
 to
>> context_tracking entry would disrupt that, but it's not a small thing to
>> reason about.
>>
>> AFAICT we need to reason about every .teardown callback from
>> CPUHP_TEARDOWN_CPU to CPUHP_AP_OFFLINE and their explicit & implicit
>> dependencies on other CPUs being STOP'd.
>
> You're raising a very interesting question. The initial point of stop_mac=
hine()
> is to synchronize this:
>
>     set_cpu_online(cpu, 0)
>     migrate timers;
>     migrate hrtimers;
>     flush IPIs;
>     etc...
>
> against this pattern:
>
>     preempt_disable()
>     if (cpu_online(cpu))
>         queue something; // could be timer, IPI, etc...
>     preempt_enable()
>
> There have been attempts:
>
>       https://lore.kernel.org/all/20241218171531.2217275-1-costa.shul@red=
hat.com/
>
> And really it should be fine to just do:
>
>     set_cpu_online(cpu, 0)
>     synchronize_rcu()
>     migrate / flush stuff
>

That's what I was thinking as well, at the very least for the
cpu_online_mask bit.

> Probably we should try that instead of the busy loop I proposed
> which only papers over the problem.
>
> Of course there are other assumptions. For example the tick
> timekeeper is migrated easily knowing that all online CPUs are
> not idle (cf: tick_cpu_dying()). So I expect a few traps, with RCU
> for example and indeed all these hotplug callbacks must be audited
> one by one.
>
> I'm not entirely unfamiliar with many of them. Let me see what I can do...
>

Here be dragons :-)


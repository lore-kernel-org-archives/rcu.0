Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2221CA01
	for <rcu@vger.kernel.org>; Wed, 26 Feb 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588779; cv=none; b=f8ZCybtwu5/k1KLBN6Vc4kBGAznDJJjkZg/q0Dr9IpWoqmxiWBW4sEL14wuWA4e8Z+186R7Go1Z/78f7dnM31C9JjOA4otVsLlGR4IRcQWvnnKA4QwZGJd9wJGFfmYkV2YSztgSEJOEEvyfTS6ANh2Pi9E+XtK+gTzx0AH7P0Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588779; c=relaxed/simple;
	bh=Qf/Qm0nkzf7U3vlvRsLDs3vQoV9ABJSWnA6WtOiN2ig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D+58hBp18OmDeZCFEqakEaqutkwmrX8DtPYDjTlAuSdBGYHLKcmxoMv4f1FHlZFRZnLD3kyvCEcIU02GG63pERlP9qjhyrHPTXsajXPXknR9H+qrcI1fmRNELnAAM2JkCZPCqpinD0vVUyLCTArcsMIIJEICihsPdvPczPsdXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+gLlw62; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+gLlw62"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740588776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qf/Qm0nkzf7U3vlvRsLDs3vQoV9ABJSWnA6WtOiN2ig=;
	b=J+gLlw62K7t4nQLqh/eCztgxf5Fg2RUFnZfalzbLz7G4JkaSaI98fxLoJofLamUdKiq9lF
	AR5TImaky7EeD9LjA8lc2AfffaIe1F5zPSAVzupIlXI8hJbREi5Xvylty0oavr+Tqbm+xj
	K1XIY0YigzYySnTUVOWTEqhsAoXWxVI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-Li4MqkahPvKXT_bq7ilrEw-1; Wed, 26 Feb 2025 11:52:55 -0500
X-MC-Unique: Li4MqkahPvKXT_bq7ilrEw-1
X-Mimecast-MFC-AGG-ID: Li4MqkahPvKXT_bq7ilrEw_1740588774
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4388eee7073so4954995e9.0
        for <rcu@vger.kernel.org>; Wed, 26 Feb 2025 08:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588774; x=1741193574;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf/Qm0nkzf7U3vlvRsLDs3vQoV9ABJSWnA6WtOiN2ig=;
        b=xHUbkXrGTeocD65jJnO8si7NXtEzRzfcJMQQIk5YQFGQX0dYytasdTk3TldL0k6Pm8
         5vlHiZ/JNgwkrr7b5kF8Nsvg0WDiH/c7bSHUla6JL3eXbhRG403Mt0hBb0DCSaJr/6cT
         K4ZwZ/2Xs0B/XrMbIbZXLdPPBt3NnoO2j5623H2z12dNmBFrudgY1rKS4mjlxAy9UybQ
         WNWqTZXmVvZuL9Ezg8Q6ukzOlWz934/WmCKI4zUy6VOtL7UUiF86jtHlx9fR2yYkjZZM
         NmcGvNvh2NT9qL8L9Ew3ph/PnAi0As5u9jistZ3lJlw99UbGlg+lJZbKtghsTkyGI3iV
         8PwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/EWAZJpk7jv2+rUMNjgx8S9ybQylczLHatR5E2ercl08Ppm3HDCj1ehT43jhgC77VMyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp2DaG8eVkkUTy6sKYvRbw1FzcWpLvHsAEubPlkWfHcEeA5dNQ
	TTUJLfG71FcKNNhi2ADLs+PqpN1CoYZZ5SAYzGfqpOwvWcsarPDtKy2/otdHrjQEJUZ882i6BvE
	muw8hH56JSjmEOi1DcFgdyK5hc8Zq3cV7iDImni21azwTyAlAaw==
X-Gm-Gg: ASbGncvYxhSDXqzNEH+/SrM9G72mBUQtGjS0ry+30bk65OwqeTaI9xTrshUbHJfMwUM
	qGq6ZVNNA/dUXljsanJ5RkrE2pkCXLlKb5ePt9qW+UODTlb8fcBdJakEbDvwt0QJ7DONbnlocyu
	V4gpUeiENIJauq/iq+W6kgD8bRwt4U+ell/cm12LBxhddS/cNt1E9k7nFicUoudE/PakpoTXA4M
	E3w6bKw0ilG78DIQvhBoK2ylm1pzfv/xB/maioqyald/sGpOhqQm9TAOx2wNYOV3CK34ouetAGc
	8WQj9GQujDrxtp1RVzjVNpRkxvIvv8DzZ1O8HQe85lX9HMGi6g1lhETeoRdL14ijT7d5JdzRqEM
	4
X-Received: by 2002:a05:600c:ca:b0:439:91c7:895a with SMTP id 5b1f17b1804b1-43afddc6489mr798095e9.7.1740588774318;
        Wed, 26 Feb 2025 08:52:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWpDWParbyEFSiQubNArY/pYMHk4T+vY7Yfjqs/xu0tXoSgFv+Leti7F7TfR+hujI+3HmBjw==
X-Received: by 2002:a05:600c:ca:b0:439:91c7:895a with SMTP id 5b1f17b1804b1-43afddc6489mr797035e9.7.1740588773857;
        Wed, 26 Feb 2025 08:52:53 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390d98c0642sm2242326f8f.81.2025.02.26.08.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:52:53 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>, Jann Horn <jannh@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
 <alexey.amakhalov@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski
 <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph
 Hellwig <hch@infradead.org>, Shuah Khan <shuah@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
In-Reply-To: <408ebd8b-4bfb-4c4f-b118-7fe853c6e897@intel.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
 <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez1EAATYcX520Nnw=P8XtUDSr5pe+qGH1YVNk3xN2LE05g@mail.gmail.com>
 <xhsmh34gkk3ls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <352317e3-c7dc-43b4-b4cb-9644489318d0@intel.com>
 <xhsmhjz9mj2qo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d0450bc8-6585-49ca-9cad-49e65934bd5c@intel.com>
 <xhsmhh64qhssj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <eef09bdc-7546-462b-9ac0-661a44d2ceae@intel.com>
 <xhsmhfrk84k5k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <408ebd8b-4bfb-4c4f-b118-7fe853c6e897@intel.com>
Date: Wed, 26 Feb 2025 17:52:50 +0100
Message-ID: <xhsmhfrk0lkbh.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/02/25 09:38, Dave Hansen wrote:
> On 2/20/25 09:10, Valentin Schneider wrote:
>>> The LDT and maybe the PEBS buffers are the only implicit supervisor
>>> accesses to vmalloc()'d memory that I can think of. But those are both
>>> handled specially and shouldn't ever get zapped while in use. The LDT
>>> replacement has its own IPIs separate from TLB flushing.
>>>
>>> But I'm actually not all that worried about accesses while actually
>>> running userspace. It's that "danger zone" in the kernel between entry
>>> and when the TLB might have dangerous garbage in it.
>>>
>> So say we have kPTI, thus no vmalloc() mapped in CR3 when running
>> userspace, and do a full TLB flush right before switching to userspace -
>> could the TLB still end up with vmalloc()-range-related entries when we're
>> back in the kernel and going through the danger zone?
>
> Yes, because the danger zone includes the switch back to the kernel CR3
> with vmalloc() fully mapped. All bets are off about what's in the TLB
> the moment that CR3 write occurs.
>
> Actually, you could probably use that.
>
> If a mapping is in the PTI user page table, you can't defer the flushes
> for it. Basically the same rule for text poking in the danger zone.
>
> If there's a deferred flush pending, make sure that all of the
> SWITCH_TO_KERNEL_CR3's fully flush the TLB. You'd need something similar
> to user_pcid_flush_mask.
>

Right, that's what I (roughly) had in mind...

> But, honestly, I'm still not sure this is worth all the trouble. If
> folks want to avoid IPIs for TLB flushes, there are hardware features
> that *DO* that. Just get new hardware instead of adding this complicated
> pile of software that we have to maintain forever. In 10 years, we'll
> still have this software *and* 95% of our hardware has the hardware
> feature too.

... But yeah, it pretty much circumvents arch_context_tracking_work, or at
the very least adds an early(er) flushing of the context tracking
work... Urgh.

Thank you for grounding my wild ideas into reality. I'll try to think some
more see if I see any other way out (other than "buy hardware that does
what you want and ditch the one that doesn't").


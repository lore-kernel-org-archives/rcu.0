Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470E1F7077
	for <rcu@vger.kernel.org>; Fri, 17 Jan 2025 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121500; cv=none; b=sdoI1Zpa1wV+2Nux1/T1hBsEFT7tz0gEK5ioQ23T4UV8Ke15teon3QDzEURFhQhhr5VhjYJMMKX8/PrjXOIk4QJPvorle59guB+XDNsUz/WOGo311U7U41gBoyPyUBnViHVW5ZMDqzQ2bcRSSZORTEr93t4ze+GX0cr8rhN1bjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121500; c=relaxed/simple;
	bh=3uGThAIZZrxCJ1Zag/yc29l3qlAKBV2/uT4Bw7pXLWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BywZZxaObZ66WeaziSv8WwMW3Bh5l8XzKiJW6Qolp1KG7pqUu/qGLI4VCkMWSG8u7steNJGPyKUXWMnSk+o6iOQ5tYG63XPqAK0WsGyJzCsKzpz7jStPqSMhjEIJjPg5Ps/fMBsc7BbxpTB0VfBjxx3/mqjow9yVIgZhepwagMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZHV+9J1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZHV+9J1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737121498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HEKKhsO2kOL/qF9SHnIE9a8dcD47/tUh4wLid3vzvOo=;
	b=MZHV+9J1aUgCppsgpkJpQvMYzSoG8bhifFYQCfj/9s39EQl3oZJe672ABRiEOX8cuePG88
	3H4b1jduRVI2XTe2rKcWYkNV8UBEftukh2MH9GB4kpf3dz+QS0I7nla6c06YGeayOfRZVY
	03On0hJE0BKuZFwayCxYqjEIo6cGR24=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-p4s_pqnPP8aVTVKYCNVOtw-1; Fri, 17 Jan 2025 08:44:57 -0500
X-MC-Unique: p4s_pqnPP8aVTVKYCNVOtw-1
X-Mimecast-MFC-AGG-ID: p4s_pqnPP8aVTVKYCNVOtw
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-467b19b5641so42993621cf.3
        for <rcu@vger.kernel.org>; Fri, 17 Jan 2025 05:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737121496; x=1737726296;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEKKhsO2kOL/qF9SHnIE9a8dcD47/tUh4wLid3vzvOo=;
        b=HP/OZ6LVbcNhFkudmHLhfm1+B7HpfYu/Pv1Jaom0uCLc3R2eV796GP2KsajR6nkfdC
         Lx4giS9+z3vHTeifRqMWP0VObqCN9118sFJn9XRtWuwMDC9Z/zEsEzQZf5UjKi6jgvCn
         r8C52J/t5v087kVs9UG9T6QZV5UQ62wtI9bEC28z1uHTyYdGCkLpURZQ544tNAIEnvOs
         J7AA/mU7zpk1AIzK2LQzVyaJb6tz3SX5osd8FP5JRhpEnCulwgLdDhsIOfkx10T7/jWF
         rYbgZOmEtmARFmP/VnZISu1ef/4CJDPykrifxUWhuLC0a88+B5t2sSQNpwytP9pvsc/t
         E0eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnvf7NpHJg70++Kcmcc5SJApjkHq+9rOwXC4bjjK+O8sVKvh2qcamYgx4lHo5dS+oRKVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSInrhjUNg1HwsBAnUYWkK+pjDM2snWQzb/s2EyeWgYGx/VxR
	sezaEfaNzsntokhhvWJ4VU6jBvsSgmEexyZTC/nM1FFnW8+UXOshThQr6lR6X1+xcLzSAsVdzOC
	TUb+zBHcyB0KwmdkE3AKg/yeoGP4L+kz6r8emuSXTP/bllwZ0nw==
X-Gm-Gg: ASbGncseMzu+/bZDkg6PNKGkpZiEilwa42Kk7Pw4c4T9YplsmHf2F8wrYee+srXKJXE
	a0/WKn3SDZgsSVW6aYpucEXxlhNtx5QMj2YAJWDA+vg6G8APDAhssDwe0ApU5hGdkR9BYtSdytg
	TiX9pI9Ls8vt+PDkNtO1AG33kWBmb1jyT5l9OH97GPFyIQwqXPoYBF6beccOTp5m7pJKwkASKvK
	o3CYz58LpYVgRCRydZYpz5K3FmraIqUt90f4T9Z+9549Z3D6dHSFbKYbC6pVR9e6o8KzxphTLQM
	WhIyTm7XGOyyD94ZKzfpyAVvywVqOa1x6B0KWUKmgQ==
X-Received: by 2002:a05:622a:1387:b0:467:674d:237f with SMTP id d75a77b69052e-46e12ad5f7bmr40518731cf.11.1737121496625;
        Fri, 17 Jan 2025 05:44:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmIl4MCDkHkFsxi8fUyXS99BtrKRZsY+6w06Ii3eQgKuqou3xcsKirOxy10aWGIFujuL9O5w==
X-Received: by 2002:a05:622a:1387:b0:467:674d:237f with SMTP id d75a77b69052e-46e12ad5f7bmr40518371cf.11.1737121496270;
        Fri, 17 Jan 2025 05:44:56 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e1042ef63sm11228641cf.71.2025.01.17.05.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 05:44:55 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com
Cc: Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
 <alexey.amakhalov@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven
 Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Tomas Glozar <tglozar@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Kees Cook <kees@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Shuah
 Khan <shuah@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Mike
 Rapoport (Microsoft)" <rppt@kernel.org>, Samuel Holland
 <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, Nicolas Saenz
 Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Yosry Ahmed <yosryahmed@google.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 26/30] x86,tlb: Make __flush_tlb_global()
 noinstr-compliant
In-Reply-To: <52311c3d-83cf-4dc4-bbcb-5fbca8eb249c@intel.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-27-vschneid@redhat.com>
 <52311c3d-83cf-4dc4-bbcb-5fbca8eb249c@intel.com>
Date: Fri, 17 Jan 2025 14:44:42 +0100
Message-ID: <xhsmh5xmdh7w5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/01/25 13:45, Dave Hansen wrote:
> On 1/14/25 09:51, Valentin Schneider wrote:
>> +	cr4 = this_cpu_read(cpu_tlbstate.cr4);
>> +	asm volatile("mov %0,%%cr4": : "r" (cr4 ^ X86_CR4_PGE) : "memory");
>> +	asm volatile("mov %0,%%cr4": : "r" (cr4) : "memory");
>> +	/*
>> +	 * In lieu of not having the pinning crap, hard fail if CR4 doesn't
>> +	 * match the expected value. This ensures that anybody doing dodgy gets
>> +	 * the fallthrough check.
>> +	 */
>> +	BUG_ON(cr4 != this_cpu_read(cpu_tlbstate.cr4));
>
> Let's say someone managed to write to cpu_tlbstate.cr4 where they
> cleared one of the pinned bits.
>
> Before this patch, CR4 pinning would WARN_ONCE() about it pretty quickly
> and also reset the cleared bits.
>
> After this patch, the first native_flush_tlb_global() can clear pinned
> bits, at least until native_write_cr4() gets called the next time. That
> seems like it'll undermine CR4 pinning at least somewhat.
>

The BUG_ON() should still catch any pinned bit mishandling, however...

> What keeps native_write_cr4() from being noinstr-compliant now? Is it
> just the WARN_ONCE()?
>

I don't think that's even an issue since __WARN_printf() wraps the print in
instrumentation_{begin,end}(). In v3 I made native_write_cr4() noinstr and
added a non-noinstr wrapper to be used in existing callsites.

AFAICT if acceptable we could make the whole thing noinstr and stick with
that; Peter, is there something I missed that made you write the handmade
noinstr CR4 RMW?


Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CAB19AA5D
	for <rcu@vger.kernel.org>; Fri, 17 Jan 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129180; cv=none; b=TYD/OgZvcwvegqkBMO/IG+lGlUYD0U1rH43JO4JwEmn7gGulyo/YJOVf/XLWDMChRUXkYLaiVNpZx+VpeOVAxGgmOxHSgCZu4zjYUm92jSEdn5MBucrT/vqa8ZeXx7MPhdm26CulJDaKpCbymA43hckOTfWJmNTzYk47p8SBcc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129180; c=relaxed/simple;
	bh=E7d+TpfXp3p6m5vGusLumGYBM9vV8hEetyox2i/2Tk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGEKjZ5mZRwAEAk62SIquKeUEJjSHaCrK+vOA1xsFVUdmHfMLOiHv/4R6QDhRXhgJqzqE+kb1yG/eiWdgsIavyQtwqchGfOkO9OT1aKz85ACgKwLuCveIrbGb/boy+pSjO8Q2B3339M4KH/kDLGXrpR2SVPV9xG3NcTrAKsEO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mpGqLvBn; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpGqLvBn"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so9598a12.0
        for <rcu@vger.kernel.org>; Fri, 17 Jan 2025 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737129176; x=1737733976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7d+TpfXp3p6m5vGusLumGYBM9vV8hEetyox2i/2Tk8=;
        b=mpGqLvBniVqxo77vfpJUti5+g+eBQMghQtwoA7cF331WeBcYbaNHa/0Apt7RaciHOt
         /ckZLqTt5IsP4hkw8MdqGv71PrORwCjtz07dDwHT5XtIP1WSXivZFw5I69VeeqOfcQF3
         ybe6UQGUK1sRDw7mWfl8g5yJZjAV4KfLbPCbsnEvoY2Is2Ir/+knCLlW/+DsbpZp+F67
         1YFefnkJmOsddMASB3if29JAVOaoojUkTxLWZBjkgUI3ScVoKgbxbMxoYS341oH/wb1u
         zde5v0gHpoYfKEPKNScMJekd0S1tXfitnEzMT2pHzwhXP/omYZPS3FKjadRdLXhf/Z61
         8+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737129176; x=1737733976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7d+TpfXp3p6m5vGusLumGYBM9vV8hEetyox2i/2Tk8=;
        b=ATaJF52RM0Px0QyexKHOI8v6nlped1Vb2y9V19xZO8/KjcQr8OqL8PPD4olyn0Sk6A
         eNo+TtxpM4/3PPU+b9ybcNpurlGr0jJZ9pLVbRrEu4ibuJFFblIIPQAtW+9UczVG6R8i
         5aHYQLINTbfnv4x0ptQ0B3CAAlGS74flxc6jVI0N+U/mtY5TJ8bIf63bvmdrWN1LDXBe
         nNIHgLZcwJ7qRohM8uc6KmA4g/tU+gW4lfAKCJtar/w6EAl1FR8S7CIK2meP9DgvcVhJ
         /lZJGR7yRloLzvjvkT0AF7Qi2KGFRXuFf+nuXEjJ9XDCLtIvPp3Drwof4fwndk1zRSdz
         bQtw==
X-Forwarded-Encrypted: i=1; AJvYcCXz6h5joVHsIzeQMLSKpqvbuaS1ByITV0RYakf5UfBPmqqj9UG6Xly0SUakGDDLO5nibfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJKS9sJgQQsV/ll9C6R7fZqroAxXnNNSdJrt8jSwzn15z9P80q
	x/0jzrf37sBfjNirUigW5FBaRPDRG6Zr+r2UNo66VqPcVBsKhEv9fg/ddddTF8s26GQ/FCUHhLn
	P65/d35zKVDhH58VsxbqZVDAaUuJExO6cXcT4
X-Gm-Gg: ASbGnctasYQtmpZ6Q68kMZeTILrMNoKNjVVeMs1JteEOY451J277/GM8715/A+jerjJ
	uqtZN1OSdtPG7bc5erNUOLQy05gw6BN8EuvQ9hHcR/D8xURujy7tFQrYCFHt2M2XC2g==
X-Google-Smtp-Source: AGHT+IEEkI7Iy2SK9FPAK0t7gLelF/8kGvCq2TFqgDI01h52pfAV4lOJlwJrdbZvw3hEJ10c/9do3FNZA9vfJuC5wNY=
X-Received: by 2002:a50:8e10:0:b0:5d0:acf3:e3a6 with SMTP id
 4fb4d7f45d1cf-5db7e2c3f9dmr75503a12.1.1737129175787; Fri, 17 Jan 2025
 07:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com> <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Jann Horn <jannh@google.com>
Date: Fri, 17 Jan 2025 16:52:19 +0100
X-Gm-Features: AbW1kvZJ0qyEwdtkrx_UmrEU0O4aMmTblOKPsNQ-aUYqHdGS_cvMGi3arE1PehU
Message-ID: <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer flush_tlb_kernel_range()
 targeting NOHZ_FULL CPUs
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, 
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Yosry Ahmed <yosryahmed@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 4:25=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:
> On 14/01/25 19:16, Jann Horn wrote:
> > On Tue, Jan 14, 2025 at 6:51=E2=80=AFPM Valentin Schneider <vschneid@re=
dhat.com> wrote:
> >> vunmap()'s issued from housekeeping CPUs are a relatively common sourc=
e of
> >> interference for isolated NOHZ_FULL CPUs, as they are hit by the
> >> flush_tlb_kernel_range() IPIs.
> >>
> >> Given that CPUs executing in userspace do not access data in the vmall=
oc
> >> range, these IPIs could be deferred until their next kernel entry.
> >>
> >> Deferral vs early entry danger zone
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> This requires a guarantee that nothing in the vmalloc range can be vun=
map'd
> >> and then accessed in early entry code.
> >
> > In other words, it needs a guarantee that no vmalloc allocations that
> > have been created in the vmalloc region while the CPU was idle can
> > then be accessed during early entry, right?
>
> I'm not sure if that would be a problem (not an mm expert, please do
> correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
> deferred anyway.

flush_cache_vmap() is about stuff like flushing data caches on
architectures with virtually indexed caches; that doesn't do TLB
maintenance. When you look for its definition on x86 or arm64, you'll
see that they use the generic implementation which is simply an empty
inline function.

> So after vmapping something, I wouldn't expect isolated CPUs to have
> invalid TLB entries for the newly vmapped page.
>
> However, upon vunmap'ing something, the TLB flush is deferred, and thus
> stale TLB entries can and will remain on isolated CPUs, up until they
> execute the deferred flush themselves (IOW for the entire duration of the
> "danger zone").
>
> Does that make sense?

The design idea wrt TLB flushes in the vmap code is that you don't do
TLB flushes when you unmap stuff or when you map stuff, because doing
TLB flushes across the entire system on every vmap/vunmap would be a
bit costly; instead you just do batched TLB flushes in between, in
__purge_vmap_area_lazy().

In other words, the basic idea is that you can keep calling vmap() and
vunmap() a bunch of times without ever doing TLB flushes until you run
out of virtual memory in the vmap region; then you do one big TLB
flush, and afterwards you can reuse the free virtual address space for
new allocations again.

So if you "defer" that batched TLB flush for CPUs that are not
currently running in the kernel, I think the consequence is that those
CPUs may end up with incoherent TLB state after a reallocation of the
virtual address space.

Actually, I think this would mean that your optimization is disallowed
at least on arm64 - I'm not sure about the exact wording, but arm64
has a "break before make" rule that forbids conflicting writable
address translations or something like that.

(I said "until you run out of virtual memory in the vmap region", but
that's not actually true - see the comment above lazy_max_pages() for
an explanation of the actual heuristic. You might be able to tune that
a bit if you'd be significantly happier with less frequent
interruptions, or something along those lines.)

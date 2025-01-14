Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB50F20F98F
	for <rcu@vger.kernel.org>; Tue, 14 Jan 2025 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890017; cv=none; b=kCF/idy4asND4xh3HPViIdMJbIm3IXC5Ik3fg/dcSd7z+blFIPTQxExYUDDPVDEIoE8JFpbPJO76w9EWIzhC5e+RqwFuUr6+n9qUjKiAc0V8kC6TlvsOpKswUEOeJ1RTdonHLCCf3qDCP4FZxRuQhEVucs53QK9H03TWMPq28ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890017; c=relaxed/simple;
	bh=oPosukRuS5Ny6CBCBgfqsCfB0dNx94vYjIEcmowMxlo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e1BSUs70goCLqNCsEEnG2Ptn8lxDpb1yXokwjlZgqqSrEwWs48c6DK4ZSjatQs6xJNRSFhHKLUsZ32yjpcmVTCl6R/VYOzho+vzFQrKB+PXGhJTVKJZCS8D/Q9dHbBI3x2ZSQmnRsrtF6bYW11lwqBbUPKhFCtof8WwRj4kr8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O4Spa79Z; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4Spa79Z"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9da03117so15478464a91.1
        for <rcu@vger.kernel.org>; Tue, 14 Jan 2025 13:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736890015; x=1737494815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8zpuNawVjToL3i20ZYrbUddkmOaJHAfbCZJnZQ478w=;
        b=O4Spa79Ze7aMx+eLKa/MTEJ2OKNEppiXGyLa0JbQI4GPFrrGHhypguuNt1Y89C0J3z
         SRnsPNOgnPv1MVdq6KsS4wOKls4USIirpkBvZRcrxPh1qD8Rqrc3ZYdbt/YINrCEyAs6
         wgr2q/lKBl4JejUObB9lWH5BCxeOypDi6QaN6QtJZZOTSYYJmqy5Cpmv5yMFFw0QyyGZ
         1sGT+N1bWdGiJXsuZacXmLK2BRtUSnu2IV+Qp4Z/DykjpOHDkq5dXpC7uTJoJuoykGcg
         teE0YPCVD/KGVN8Q9o7W1kOs2IUKfB2QWiCzLgg1P2Fzxq+4r56idZhZVrkt2FbwMFaP
         ovDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736890015; x=1737494815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8zpuNawVjToL3i20ZYrbUddkmOaJHAfbCZJnZQ478w=;
        b=TGuGc7wawsT9xSDSz+54eMT2amLUZT/L2GaQqrA3jgfolszQCKFaE5ZQwsijg+D/Uo
         MumsaOYrmOT46KpRXcG2ADqaWvQuxN51s+wqQQiRIppRq5y1Z+umQfXTo35S0t6kdabv
         EAd5FfSDYhfbVi7Hmidyk0f7rUYyyjrPX6gwtzwEDRtu4V6K+8jy7U+d4LehbVhb2sAu
         mO+mVm5bUuzVu/q1+5i/Fq2J+uhKZ5Q8r/W76mFRk00UyMQ5biG3nlkcilc/qbsXhKLI
         mxrhjN42ElDt8vJCFXfHHpmEMEihr6oG4r1rC4SoEvp14lBNi8/d8zUSrT+Wg4nqYjSw
         S0/A==
X-Forwarded-Encrypted: i=1; AJvYcCUK7bgU+tgS/6Sy5OYfilMNswEAOFRuTyIY+968sAZhY4KzUk4ShBpMFG5JJbMe3heS7W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlnS3W+B01agOM4FRGd8gbrw4XHZ1EPhOedLBT5k/uqiVKDMKl
	erPnVNScdqNIhDuZ+Gcg+O9HnzsZMS6CaOlBfeY7nngNOe8XQOgdFwubgbZEjh1/VYdQQhcX2kK
	2jg==
X-Google-Smtp-Source: AGHT+IGDv4Ej+tMoSohr/AoTazwT/WbetgA7Nr8qE8BLNxmtc1cUUDk0TRGuDLxFKlrZpHzOjZy+L7iCKdA=
X-Received: from pjbsx15.prod.google.com ([2002:a17:90b:2ccf:b0:2ef:8ef8:2701])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:544b:b0:2ee:9902:18b4
 with SMTP id 98e67ed59e1d1-2f548f61fe6mr37131771a91.27.1736890015061; Tue, 14
 Jan 2025 13:26:55 -0800 (PST)
Date: Tue, 14 Jan 2025 13:26:53 -0800
In-Reply-To: <20250114175143.81438-26-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-26-vschneid@redhat.com>
Message-ID: <Z4bWnWYqu1LaD-JG@google.com>
Subject: Re: [PATCH v4 25/30] context_tracking,x86: Defer kernel text patching IPIs
From: Sean Christopherson <seanjc@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, Peter Zijlstra <peterz@infradead.org>, 
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
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
	Geert Uytterhoeven <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 14, 2025, Valentin Schneider wrote:
>  static __always_inline void arch_context_tracking_work(enum ct_work work)
>  {
>  	switch (work) {
> -	case CT_WORK_n:
> -		// Do work...
> +	case CT_WORK_SYNC:
> +		sync_core();

Not your bug, but serialize() needs to be __always_inline.  Not sure what exactly
caused it to be uninlined, but this is the obvious new usage.

vmlinux.o: warning: objtool: __static_call_update_early+0x4e: call to serialize() leaves .noinstr.text section
vmlinux.o: warning: objtool: ct_work_flush+0x69: call to serialize() leaves .noinstr.text section

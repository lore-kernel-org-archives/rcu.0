Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF202F5A1B
	for <rcu@vger.kernel.org>; Tue, 14 Oct 2025 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439779; cv=none; b=UAZUpeC+NmZ7LKrXZM2L5xCBEmQ+I3g2ojCiKkUBvRsT6enL0R3cuVkrK01jp6eqxhNmVb88AwwWTGRFedxplJxyMwDyESYVcKkjO13JWfyQ7DAmA977Hy0eT+9tnoNDPWyupC1XOc1kiAgHyVKM5cft3pANWRi0CjkEb0pYhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439779; c=relaxed/simple;
	bh=/u5e/qJ2sRdwo1224SVU8XP3U/yMMEn1jbJARlu70Tk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ig+9/DZ61ar0D7bxUdrEY6QBkOUgOBmN9Z12rdrreE40s11sxbliHBthxd5sdXxdjyi7nKvn4laxE4IKkuRmSAnarLfPCB3dvL+cHMv7wpZ++ePNS8R3wttBNztHZrWxLPdzmwbm0dDjOfJt83qRQD6kyJEqe4Zas98vt+xYTfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e83mDdrq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e83mDdrq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760439777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s2r/L8/q4C9e2I164NDxUGdYhK/0nvlG6dMGzaNBqVg=;
	b=e83mDdrqUjDTuwZOBUhrBr3TEQ/TkIV8qTEniGUfnpBREMz0qkkI/uMbWOP4Dgm+hIdaNX
	3moPEZQkkSVDIOsXJulDC95g9GeF0uOMCE/NtlX2T1xrFCJhz6UsRK8B9MFTOQy6Nw9qvD
	X4lXGxiqvUIynZmtSwM0Hy9XFEWA4EI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-Ux6hsmVxMuaVY3qZJ95P_g-1; Tue, 14 Oct 2025 07:02:56 -0400
X-MC-Unique: Ux6hsmVxMuaVY3qZJ95P_g-1
X-Mimecast-MFC-AGG-ID: Ux6hsmVxMuaVY3qZJ95P_g_1760439775
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso38997205e9.3
        for <rcu@vger.kernel.org>; Tue, 14 Oct 2025 04:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760439774; x=1761044574;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2r/L8/q4C9e2I164NDxUGdYhK/0nvlG6dMGzaNBqVg=;
        b=KpqYNDix+7Jy8aatRcitKMYT6Rr72WJtJhHbhcQVJGsbeXYvlt3jgYerebnbpPLH0Y
         6AcGvOU92c9xfervrWavWNqNPYDlFLvaR0QpEgWI0HkQ0Oc3y1ibLwlfIFnphyfmV3Ui
         +CEErpvM3OxK8lqU+5yUJC1hjWkCJgvyYhLGqGwhQ7/RehF4dBvZSeCYxBqOpHbSSq6R
         wQJzz1l05k0TdWOP62qdBntVaN8qgCJ3UqkvW+Tkd7obWhWfaHXLDVNGbGPwgIjG13Uw
         YLZz1dWa3UqJ1bAIEWrf+yTqlqj03v2iETUI0Cb2Cx1KI6r6teMMpzMCR/PydMSpKKKg
         ntRw==
X-Forwarded-Encrypted: i=1; AJvYcCWtrFKoO7wrfSo1PFikQDiGsReO7Dx+dcQCo0Pddld0QANMzfEaYb3O6BXgpr2mHDaLDgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHPy5MdAaB0UhklvizzBLNm4rzydCSBix9YEsJE2W8sBBQ8R/
	BfgVy3w1jwhpEXBCBz9+GLW7XuF2dOkkNniiC3MguLRby0XczxJ36IyehmCVo/3a/gsymHohcqw
	HmeWpfDJhFEYwif6RKh8NzKouQbJeyAeXyhmhiI9gtEdrJZrBGf3igw==
X-Gm-Gg: ASbGnculVVI3hp2uQEjE0zWz+j06nWyqORu8tR/L5n38RKdwnaGH52CSGnrqIqZxxfK
	hSIYDb4hMKzAyja6Z/O/9LyOtzDpcxyR9wg9UhgpHBA6ZOwJI8fY8oAX5fZQVDd5UNwWu9qRFGK
	aUFASJX+1p10GnrtNAFRj0UvF+97LmZQV5BdrHVdjEZEY0dFOkrJ6wLLXrfGTGaHI0iWxT++2Pd
	HdwSlZxsAvUq4zqTGz40ISDuFHgiA7KfpDIV8o7aRcPz9B2XTx0QZMcGMjQVC4jP8aaeJSnK69l
	LvzLyHJydkUVIvXPrC0/LOUAkV+p06LSweL9QeSoMcI2sp9OP/2I3r2IDAOeobJuaFbSSuwU2SI
	1ovq3Lp3dwMVUtQ51LcJBjBelkA==
X-Received: by 2002:a05:600c:4752:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46fa9af8fb0mr181929395e9.17.1760439774565;
        Tue, 14 Oct 2025 04:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCodl08uTX0ubswP5nTiGxebtIpD1Qw4JnrqS3e+W7M5qhx4w6eQs0AuIjitoXX5t0l6/vwQ==
X-Received: by 2002:a05:600c:4752:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46fa9af8fb0mr181928825e9.17.1760439774097;
        Tue, 14 Oct 2025 04:02:54 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f2f72e18sm1737515f8f.0.2025.10.14.04.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:02:52 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
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
Subject: Re: [PATCH v6 19/29] KVM: VMX: Mark vmx_l1d_should flush and
 vmx_l1d_flush_cond keys as allowed in .noinstr
In-Reply-To: <aO2S3oZwOW_UgAci@google.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-20-vschneid@redhat.com>
 <aO2S3oZwOW_UgAci@google.com>
Date: Tue, 14 Oct 2025 13:02:50 +0200
Message-ID: <xhsmhwm4xpwyt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 13/10/25 17:01, Sean Christopherson wrote:
> On Fri, Oct 10, 2025, Valentin Schneider wrote:
>> Later commits will cause objtool to warn about static keys being used in
>> .noinstr sections in order to safely defer instruction patching IPIs
>> targeted at NOHZ_FULL CPUs.
>>
>> These keys are used in .noinstr code, and can be modified at runtime
>> (/proc/kernel/vmx* write). However it is not expected that they will be
>> flipped during latency-sensitive operations, and thus shouldn't be a source
>> of interference wrt the text patching IPI.
>>
>> Mark it to let objtool know not to warn about it.
>
> Can you elaborate in the changelog on what will happen if the key is toggle?
> IIUC, smp_text_poke_batch_finish() will force IPIs if noinstr code is being
> patched.

Right!

> Even just a small footnote like this:
>
>   Note, smp_text_poke_batch_finish() never defers IPIs if noinstr code is
>   being patched, i.e. this is purely about silencing objtool warnings.
>
> to make it clear that there's no bug/race being introduced.

Good point. How about:

"""
Later commits will cause objtool to warn about static keys being used in
.noinstr sections in order to safely defer instruction patching IPIs
targeted at NOHZ_FULL CPUs.

The VMX keys are used in .noinstr code, and can be modified at runtime
(/proc/kernel/vmx* write). However it is not expected that they will be
flipped during latency-sensitive operations, and thus shouldn't be a source
of interference for NOHZ_FULL CPUs wrt the text patching IPI.

Note, smp_text_poke_batch_finish() never defers IPIs if noinstr code is
being patched, i.e. this is purely to tell objtool we're okay with updates
to that key causing IPIs and to silence the associated objtool warning.
"""


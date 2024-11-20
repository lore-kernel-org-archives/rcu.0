Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDFA13BC12
	for <rcu@vger.kernel.org>; Wed, 20 Nov 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119328; cv=none; b=AMmGauTNoaLRARa5JU3BqK/rDzIauC3pKOHs3JZNCj1RLq2Uz5qOpk8ovYJEKF5QmZUoEAPBgxOmLvTFw+eTZx9+zrZTY7/IkRgn/PxfiyXiohzSuByCJxbUlW+nbif0QwXdmVFNxASdvvoeGA1tso6cyDMMx2QTtHvWppLIGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119328; c=relaxed/simple;
	bh=VNWYPyllDhn6wyHA8vHCBZcrdTpypW9KdBxrUGgTSiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=smsugW3YJom1LDkppPe7xackH4lf7SULSl9+p9TuG3+yBftbKH2Oh1yYI3gZF4iFOU7rk0arlcEphhUAi+ZbzQtnYRgtS5zW306hnQDMhpPsyNKSL6ofGSNIDTnUOlpPG/0LGJ3pw1a18I/3ajZqOEm056IQIgV5Ty8EZIx5ebc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiqBWHj5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiqBWHj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732119325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s9neiNV5Ecw1Rm63FFkLc6Zp+LPvspTbTCjcardEBqA=;
	b=OiqBWHj5xdmkTaP9TYyxtcJLm60drwK/Ntx3+LifusSd0pxADNbVSnCTnY0YFS1ciMqE46
	5wp/UPkwNj5sCBtFnBRjWos7ME+1ZgMellPJJkA0zv8aujHF2EKZVKhXCdXEyDavCKik/6
	6i9nXqRCqFqfi+KK2zP4ZP7x60/v+WY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-nUu4YSnhME-naN59Rr56Vw-1; Wed, 20 Nov 2024 11:15:24 -0500
X-MC-Unique: nUu4YSnhME-naN59Rr56Vw-1
X-Mimecast-MFC-AGG-ID: nUu4YSnhME-naN59Rr56Vw
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-460b8f4bab8so37623111cf.2
        for <rcu@vger.kernel.org>; Wed, 20 Nov 2024 08:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119324; x=1732724124;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9neiNV5Ecw1Rm63FFkLc6Zp+LPvspTbTCjcardEBqA=;
        b=WZaxNUGi+LnMTNGTseciWB6YQIuS/q9kapQ2psdHZ+nWbsWWD7K64Z4tms2NpV2ujd
         r7/oey60gUl1BnbpwgHfZhYrTTFKLUxmHDDLWzGm+OPiwKMY1PNosw8BuvibpB74FZtz
         QX9EtcDUmpRinO/43NO25nMMzswQ5b6Fm9ssCgMhuu+dpYjwbBWI5Qr/M8nvKjhgMWLJ
         MsAah2+T5Vm451ROc5ACIKiO3f4223TzbWFa1xTjbMBpKkPXSLdKVGitsYpBcyInJOeL
         TPRwCpai+3yn7zjpSVtKYco2J2me/Fu/aKGwRjhwS1NbhOxmYlkV5x8EYG3RlVP47gVK
         Uxkw==
X-Forwarded-Encrypted: i=1; AJvYcCVJPLYzR6YL3BRygXHNP4X7JG7ffBb1N9z+06FdeZHXwfqNqScgkChCPEzLbMqVfdcxxtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy986dMmzsvaWqoSeW2cVS+gfSM3uhqefXYAZFiNtH/Pdz7o3Hx
	J/MvqY07IhijBAODGPp+qKVmFgnLbtta7eO9721IsMo4NvWi8C6j/QibJqskLCRpqN4gFl5/U4W
	xoUfDOOI23OicTlCZIkf/22jOHyN5C2yvAwWt3r7+u+SYwmnaUQ==
X-Gm-Gg: ASbGncv9Ls4Pva7ldLYDz4Zk3DY7skxsfliLp+OlFzNH6nG2Z3X0eu8oxM0gwQ9ZXvM
	PYE9NcKuXmWBkX47XdwojufJIWOJG+HVE0ka7rE2dk/tBj8ffNZD2aN9RzHi/6waWD9qQ5JX6HY
	VLOMXWBM01OJrxHYcQSjirBIZQ4+vwGz7snPbqIsRzU6oJ1vQiY4klSL/YRqC4TESICrb0G6BT0
	QvrPMaMi/+wucNOJBjXDJ+a4iIbuHIMmzLK5xJFNOGrCp1NLeJ5/MkaNdsI891Z1Yg3UDEJ7nX9
	yhPUJ6GlD2PjNXK+HLOKHkPpNfQkrRV6S5M=
X-Received: by 2002:a05:6214:2aa7:b0:6d4:1f86:b1f2 with SMTP id 6a1803df08f44-6d4377bd8bcmr43340296d6.11.1732119324022;
        Wed, 20 Nov 2024 08:15:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErytLY/ydBtG/c68cV9sB/Rs0q2MHssCkf2mLl/ZoHSY4DaUVm1Hfo6p7yhhfkcknSTmK2WQ==
X-Received: by 2002:a05:6214:2aa7:b0:6d4:1f86:b1f2 with SMTP id 6a1803df08f44-6d4377bd8bcmr43339716d6.11.1732119323729;
        Wed, 20 Nov 2024 08:15:23 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d43812ab67sm12352206d6.88.2024.11.20.08.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:15:22 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "Paul E . McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>, Sami Tolvanen
 <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>, Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel
 Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 04/15] rcu: Add a small-width RCU watching
 counter debug option
In-Reply-To: <20241120145049.GI19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-5-vschneid@redhat.com>
 <20241120145049.GI19989@noisy.programming.kicks-ass.net>
Date: Wed, 20 Nov 2024 17:15:14 +0100
Message-ID: <xhsmh1pz5j2zx.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/11/24 15:50, Peter Zijlstra wrote:
> On Tue, Nov 19, 2024 at 04:34:51PM +0100, Valentin Schneider wrote:
>> A later commit will reduce the size of the RCU watching counter to free up
>> some bits for another purpose. Paul suggested adding a config option to
>> test the extreme case where the counter is reduced to its minimum usable
>> width for rcutorture to poke at, so do that.
>> 
>> Make it only configurable under RCU_EXPERT. While at it, add a comment to
>> explain the layout of context_tracking->state.
>
> Note that this means it will get selected by allyesconfig and the like,
> is that desired?
>

I would say no

> If no, depends on !COMPILE_TEST can help here.

Noted, thank you!


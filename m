Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2522FA0ED
	for <rcu@vger.kernel.org>; Wed, 29 Oct 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733987; cv=none; b=YQL1E0vb7pE7PCjzG+ZYbjdocNWjrtaXL/DjI1bkPvo1qHtvGXZVnHgzMrUevZCw6OXP30jHU+RY0zCHUABKQT2Hvjqr0BBWvKZawdC7Y3YKqv77jY4gmX+b1k9Ufz+wkJO1VYqmH/lTNAayfC3HWyYhBuXj/25yGXvhroLHBIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733987; c=relaxed/simple;
	bh=hJtwdK757CQ9l88ORyal3ZjM4fe6wz7nP/MxATLRzCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UB2tv9DG+WVHQ9Rk73MXekzbB0+RjFr712Y11J6nNt3safid9ITRBxV9p3xFns0W/KK4IoIpLn+Rzjm69ZZXhdADnBi8Yv2IZiIGfIVI5FbYmFOURzkYX0+/3JLEWc05EqoSsvVLDH+VqeVAmS2ocI1gbJ5HLsIm6JmM1hZxQk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CV146RSo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CV146RSo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761733984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJM20FESPr5Q3wolT/mFDxUYnwba82V6xz3P+wmiM7o=;
	b=CV146RSoTZLDrr1/4uZkSWJT0JuGP0EKjIQ/i9woB9Xwlt/7OciiuQ4WZfSGDoPKSdRhhv
	hH03ls+q4STK7lyEiqEnd4oDVND1QdV3GtKnMOXe+23e2G+gKcr5kO3xZZWRJfmmzxXxjp
	Z9Yf2L3KbHhq3mz5OmaJSkkctNoM5cE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-1MAL0n3lNKe9GcI1NzRFGQ-1; Wed, 29 Oct 2025 06:33:03 -0400
X-MC-Unique: 1MAL0n3lNKe9GcI1NzRFGQ-1
X-Mimecast-MFC-AGG-ID: 1MAL0n3lNKe9GcI1NzRFGQ_1761733982
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso53689675e9.3
        for <rcu@vger.kernel.org>; Wed, 29 Oct 2025 03:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733982; x=1762338782;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJM20FESPr5Q3wolT/mFDxUYnwba82V6xz3P+wmiM7o=;
        b=Yg2vasCoyrzqfols1KiFul+upfa3/zUqs8kVtQokPuMbJzaINt4lYJdQUToo3yg6/b
         ghRNAb2+ejTjX5rmvEnb8iE4fug8DI4QASC7Za1YRQdi+kPstddiA/qWrRs1tcuXb6d/
         2/JdDAxJT/n76vSez0NZ3kcYRo5yzJiEowC0FCrAKeCSH6HZAhtBxu8igx7soesWij6M
         XmRkjG5C9hOF/qIuscb2udEZTy0Q4FQxPva9V5BRyQZ6mPYUgmEBtiT1ipwmvmdNPAZE
         by+8u482gK8D54+niTa7Nytgld9Thl9U8UaEfqxQecpWSd4JnaUvRQ8wqQ+D89aKj/Ji
         CFhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4wba44lVZ4beiAiMNcrBt7fm9XVgeVm7iu60Jg0KPGQvemGZmCnTcBKEfn3LQoqWwoZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFeIGN1egp/3DGPHHIGTVisASCMsiXMOUvD9b23n7A+Xp8MFBg
	0YiME3RNYtu8eS63vDeJ4xbafPXb2c2+AOMQtAV0ObnHzn44u7NCTCGf7P1FA2tMR8xAq5Quo+w
	HxPVZ5mpdZhX4DRNB8jtikF4o792prHTuZiSHd9JyNBjDJERG4fFF5w==
X-Gm-Gg: ASbGncsSnG+6H3QnuvjqMQ7UAP6CTJ60ohq2l4i3S/HdPOyUcyM7mSKmje/k9LVA8Zy
	w1X3qYFQpcQEz5dg40UZQZyYcxJJPgadPP8okU9KsStE/o4LEumpsARnKFkFXz0UXsVoyIa+ry+
	rc3rXoxtowV+CHYIYvjTkZH5EHZDLiVXlQMghy81+FpAU2VuVktHTBngfA404W1skf7Bqgurlgs
	t2ajYx2tL5BsOHvjSU67JBwjJUhkJgzwEPnbOXNv/nCEH5cOQLpY3TZNqkXwoXzfO25fj5eZ14y
	V/OOU591eUum0kyiRwONsHOPjUGV8cNZ3iwOj2p4PrHdGn1lk/lbEuSXAuk+FeT7gaJlmtpiqGf
	MwTZcwf8riuvMUdN8mChvg2h5aT1lKMOKm5jRuDwa3TNqfEVTdUPGqOazxh1l
X-Received: by 2002:a05:600c:64c4:b0:477:bb0:7528 with SMTP id 5b1f17b1804b1-4771e1da0c8mr21409135e9.22.1761733981771;
        Wed, 29 Oct 2025 03:33:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxlh/PGW1+wNXuO1RQYN4fEeAqw5AdQXtt4ynjbr63hSK8Qg5GeiiDecSDqHTa53KxpVgVKg==
X-Received: by 2002:a05:600c:64c4:b0:477:bb0:7528 with SMTP id 5b1f17b1804b1-4771e1da0c8mr21408835e9.22.1761733981314;
        Wed, 29 Oct 2025 03:33:01 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b79cbsm25638297f8f.4.2025.10.29.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:33:00 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, Phil Auld <pauld@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney"
 <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, "David S. Miller" <davem@davemloft.net>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <aQDuY3rgOK-L8D04@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aQDuY3rgOK-L8D04@localhost.localdomain>
Date: Wed, 29 Oct 2025 11:32:58 +0100
Message-ID: <xhsmhzf9aov51.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/10/25 17:25, Frederic Weisbecker wrote:
> +Cc Phil Auld
>
> Le Fri, Oct 10, 2025 at 05:38:10PM +0200, Valentin Schneider a =C3=A9crit=
 :
>> Patches
>> =3D=3D=3D=3D=3D=3D=3D
>>
>> o Patches 1-2 are standalone objtool cleanups.
>
> Would be nice to get these merged.
>
>> o Patches 3-4 add an RCU testing feature.
>
> I'm taking this one.
>

Thanks!

>>
>> o Patches 5-6 add infrastructure for annotating static keys and static c=
alls
>>   that may be used in noinstr code (courtesy of Josh).
>> o Patches 7-20 use said annotations on relevant keys / calls.
>> o Patch 21 enforces proper usage of said annotations (courtesy of Josh).
>>
>> o Patch 22 deals with detecting NOINSTR text in modules
>
> Not sure how to route those. If we wait for each individual subsystem,
> this may take a while.
>

At least the __ro_after_init ones could go as their own thing since they're
standalone, but yeah they're the ones touching all sorts of subsystems :/

>> o Patches 23-24 deal with kernel text sync IPIs
>
> I would be fine taking those (the concerns I had are just details)
> but they depend on all the annotations. Alternatively I can take the whole
> thing but then we'll need some acks.
>
>> o Patches 25-29 deal with kernel range TLB flush IPIs
>
> I'll leave these more time for now ;o)
> And if they ever go somewhere, it should be through x86 tree.
>
> Also, here is another candidate usecase for this deferral thing.
> I remember Phil Auld complaining that stop_machine() on CPU offlining was
> a big problem for nohz_full. Especially while we are working on
> a cpuset interface to toggle nohz_full but this will require the CPUs
> to be offline.
>

Yeah that does ring a bell...

> So my point is that when a CPU goes offline, stop_machine() puts all
> CPUs into a loop with IRQs disabled. CPUs in userspace could possibly
> escape that since they don't touch the kernel anyway. But as soon as
> they enter the kernel, they should either acquire the final state of
> stop_machine if completed or join the global loop if in the middle.
>

I need to have a think about that one; one pain point I see is the context
tracking work has to be NMI safe since e.g. an NMI can take us out of
userspace. Another is that NOHZ-full CPUs need to be special cased in the
stop machine queueing / completion.

/me goes fetch a new notebook

> Thanks.
>
> --
> Frederic Weisbecker
> SUSE Labs


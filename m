Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC124B28
	for <rcu@vger.kernel.org>; Wed, 20 Nov 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119913; cv=none; b=Xa+82IbrPCAcNznJKDILSbFRDIzOYzpEQ3ozFWcXRRGQMZpJBP4yh8MzbAUwoHPizngtQ7aaCxuAXXfgLBOQC5gayKmMuJrU/aHr2QhiRbgQlldDpge0VQSfN1LYiB71M+xYh9NZiIAURUP8aus2kPmzjELwFcFqqoAmYYdueS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119913; c=relaxed/simple;
	bh=93S9b76DLfHg1j3hGUFKC6KusKfH4b9Sf6zjZ5dEV2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r/9eza+65BUg0Ltzz3D3GW8UehWtjH6UBUpdUs+hJbKNA37X9DJ8pLsUviAwWiX1uwM5Rjw3iJr+cOf6upyiNGEY6556sszBUI2kg33o8QZvKIiCT4wBf52XgagtCZvEiG/hei15zcYg/+vTmOKe6+b4Nt10GbaO2UymAEd2ol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFD5riz7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFD5riz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732119910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KnMkGleZIsu11xw1ZkKAb4+ieA42pt74OZ0CpBzWkW0=;
	b=WFD5riz7ZMT56WWsGATxdbza2YsE0HQVIF3WnflL/TSkjH0EbaiJQaDJSREZkb8CBY3KCj
	iWis/bA1wk7PplmQB5rNKJIQC6KZR9E5mPPSawrZXEy1XhITIEghsGPv8KJo17uqNTjfz3
	CCzcmYJ5vZ2OIemlu/YO5ho2cYFRrPU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-L0ysj7wUPj-6yvIwWj1PJw-1; Wed, 20 Nov 2024 11:25:08 -0500
X-MC-Unique: L0ysj7wUPj-6yvIwWj1PJw-1
X-Mimecast-MFC-AGG-ID: L0ysj7wUPj-6yvIwWj1PJw
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b35758d690so103894185a.1
        for <rcu@vger.kernel.org>; Wed, 20 Nov 2024 08:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119908; x=1732724708;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnMkGleZIsu11xw1ZkKAb4+ieA42pt74OZ0CpBzWkW0=;
        b=FTB2arMrcOiqJeiYxpz/wDYW/xWw58gjnAfTB/6FAYinq4+ecEd4h+K2xmcHkycxzM
         ifSyxOgQR13qLQAjyyUMQJazInvnmuPXLVXqmlUQLitpKe1DNopBvIqHrtMVV2oZvDo9
         3zmYDt+5NKTwkZPlZjKOk38A878KET3VdPFIKQ/sX7mCfbz+RBE55i6Jal0tWHAwTdjF
         fKeNH0IqUy0qYaxfgCubGtraFqVuChuQfPsbg45PqJjDeWoHFhJYUQasAyhqHES2OmCV
         OUOu63EaSiWamvUILUZB7AAFTM0x6SyMhRLOg5gMMHfXtUS+c69lDVcKErFRHxBUfcDs
         DEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/TL8B2SHJiOuFfNCUNoypKLkSk4ElNS9jmXdqrYkYuN5Fn0XRsMDuoqtUtoKZv09E+KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtS9TLx/aR9qp3zj3kV4w6zLu+NfiLlGd4+zIqYC2HFaYxJRlb
	B1KKmU28zBd/zL0VI7RmU6A0MqGMzWbx6ca8dW9NNyYNG5M2dSEPMpTe/Y2aC/FfHfnxVa9fAtH
	rQ10iadQO4c2NN4B4rwaC0YOUrU9KLSjQC5n8Y0F/R7hHGgH1wA==
X-Received: by 2002:a05:620a:1993:b0:7a9:be53:fe3b with SMTP id af79cd13be357-7b42edcbc1bmr441519585a.14.1732119908210;
        Wed, 20 Nov 2024 08:25:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+5agK6i6snnGPwkWZs91MFHpm70SIo/e9jAKzDpAFTE1YXLtw0mxvEd1b9vUkNxYONzCDpA==
X-Received: by 2002:a05:620a:1993:b0:7a9:be53:fe3b with SMTP id af79cd13be357-7b42edcbc1bmr441510785a.14.1732119907854;
        Wed, 20 Nov 2024 08:25:07 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b4852400a3sm112207985a.96.2024.11.20.08.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:25:07 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li
 <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Jason Baron <jbaron@akamai.com>, Kees Cook
 <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, Ard
 Biesheuvel <ardb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Juerg
 Haefliger <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
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
Subject: Re: [RFC PATCH v3 06/15] jump_label: Add forceful jump label type
In-Reply-To: <20241119233902.kierxzg2aywpevqx@jpoimboe>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241119233902.kierxzg2aywpevqx@jpoimboe>
Date: Wed, 20 Nov 2024 17:24:59 +0100
Message-ID: <xhsmhy11dhnz8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/11/24 15:39, Josh Poimboeuf wrote:
> On Tue, Nov 19, 2024 at 04:34:53PM +0100, Valentin Schneider wrote:
>> Later commits will cause objtool to warn about non __ro_after_init static
>> keys being used in .noinstr sections in order to safely defer instruction
>> patching IPIs targeted at NOHZ_FULL CPUs.
>
> Don't we need similar checking for static calls?
>

/sifts through my notes throwing paper all around

Huh, I thought I had something, but no... Per the results they don't seem
to be flipped around as much as static keys, but they also end up in
text_poke_bp(), so yeah, we do. Welp, I'll add that to the list.

>> Two such keys currently exist: mds_idle_clear and __sched_clock_stable,
>> which can both be modified at runtime.
>
> Not sure if feasible, but it sure would be a lot simpler to just make
> "no noinstr patching" a hard rule and then convert the above keys (or at
> least their noinstr-specific usage) to regular branches.
>
> Then "no noinstr patching" could be unilaterally enforced in
> text_poke_bp().
>
>> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
>> index f5a2727ca4a9a..93e729545b941 100644
>> --- a/include/linux/jump_label.h
>> +++ b/include/linux/jump_label.h
>> @@ -200,7 +200,8 @@ struct module;
>>  #define JUMP_TYPE_FALSE		0UL
>>  #define JUMP_TYPE_TRUE		1UL
>>  #define JUMP_TYPE_LINKED	2UL
>> -#define JUMP_TYPE_MASK		3UL
>> +#define JUMP_TYPE_FORCEFUL      4UL
>
> JUMP_TYPE_NOINSTR_ALLOWED ?
>

That's better, I'll take it. Thanks!

> -- 
> Josh


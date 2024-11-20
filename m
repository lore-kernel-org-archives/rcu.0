Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8958013B58A
	for <rcu@vger.kernel.org>; Wed, 20 Nov 2024 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123511; cv=none; b=YwNvMeqPxlPHozYa8/of24vG1ManxpSzIR2WY8Gz5Sbkud2wGIfeWbY6EQJv8gQvOmsUzewPL48tp9gjgnNgHqxqKm39C9VTjq9nkqyCMjxPJG1ORyhFLZ9rQpt8b/k8nGX/e4ZI8zFsa3r5HN535FR27Uxq4eQombfJQJLWPdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123511; c=relaxed/simple;
	bh=FwMORDKyDyP9vhhjoYfbl2frmrspfqqOhp9m4o10RCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FrK0Gv/3z2YGfFHdq/ia7ETz+0kvhXVo1vECQtoabS9cuKzyPg6BEh0WLqZF+6yxvIBEpPYhDJVZ5BKbgQb9t1vWYlGSI4HoneqqZXy+mitMzGDZJDE+RFxJ6JtskLbu8gNkleOmaRvq8QilPpEMD2csXxsm7fmLDxLIA1f9QNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6Ob2J10; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6Ob2J10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732123508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NwQHeFP341Wloxfk/aGaEw2//tmnfhH7zawS7RRNPiQ=;
	b=W6Ob2J10/2c7waKBVza5oRG20BopXwlTaXFTBu4JJeTYWA7hUybcoMmWxW2zhaktk6umoy
	ZKXmgkettWjsV1+TacWdP9PHfBuNjBzxRO+As2txGxzxdrvv3hKheGm+8U75XXHkVhsFrn
	53wnXAIVOxDk6NxU1/CFRyISlKhSWnM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-Axe2sZSaO0mfyBE6P1cZsw-1; Wed, 20 Nov 2024 12:25:07 -0500
X-MC-Unique: Axe2sZSaO0mfyBE6P1cZsw-1
X-Mimecast-MFC-AGG-ID: Axe2sZSaO0mfyBE6P1cZsw
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b2f2db16cfso783674585a.3
        for <rcu@vger.kernel.org>; Wed, 20 Nov 2024 09:25:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732123507; x=1732728307;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwQHeFP341Wloxfk/aGaEw2//tmnfhH7zawS7RRNPiQ=;
        b=Cwo4sry6mV4FKxnCCFYGD88AvgPnjeBfUJSmznh7L3hoIcbLRp31U47xYLi7jfzMVK
         pIVXyVWRHwyu1nJBUQKjtFwlubI3aRou8pNHfI7ddA7+lCL2ML+YhAhzEqis6MTYyaTZ
         BNXlKdx/hyKcv+4AM1D6IZW0mN3/0Ar6SWniOGcaoxuOpNjdV58gDAsQXst+bLWpLqBe
         /0ydPPjySpFmf1XNRIJAGjV8aj3HxvfaPhkVhQTDN1EsYHt329HDw7zqq5gTBAHtTRj8
         P/jb598NDuuaU6Tna+TBZuVf3Jqw5AeZiKONZZXXjQnI/ey08WOu1ZYW5EioMcV22r0c
         9/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCW482t/yt9d+IspCyJhfa41t3lhY5OYKlE2BX/FdJTzpm13nP7TC3757LU+B9Rvnns9XoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYIQiowhHcj9uUjioEJIClUlQCoBQdIbsdovV3zdk3LwHP7rx
	VxS2qxneTxANNQKlsA7hxmc1dJpJNhKl9cD+WOLCoDdgbImuF0msSJaLxryrCAiSgxtgheI7gDq
	NmnKGKHZniimf2zpk+vj/vq3BywPqZ9K+vqAd4tM1xdbgkXLVEw==
X-Received: by 2002:a05:620a:1917:b0:7b1:4077:4922 with SMTP id af79cd13be357-7b42eed7a6cmr466277985a.56.1732123506974;
        Wed, 20 Nov 2024 09:25:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJUDAeOvDitH46UyLYMmyy56kTy+imKK6wbeTl1oyZtnWZnUtyXKV7jcsxOZ4MHEPMTaXrqA==
X-Received: by 2002:a05:620a:1917:b0:7b1:4077:4922 with SMTP id af79cd13be357-7b42eed7a6cmr466270685a.56.1732123506592;
        Wed, 20 Nov 2024 09:25:06 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b48523386esm117874785a.93.2024.11.20.09.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:25:05 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li
 <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay
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
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure
 to defer kernel TLBI
In-Reply-To: <20241120153221.GM38972@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-14-vschneid@redhat.com>
 <20241120152216.GM19989@noisy.programming.kicks-ass.net>
 <20241120153221.GM38972@noisy.programming.kicks-ass.net>
Date: Wed, 20 Nov 2024 18:24:56 +0100
Message-ID: <xhsmhldxdhl7b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/11/24 16:32, Peter Zijlstra wrote:
> On Wed, Nov 20, 2024 at 04:22:16PM +0100, Peter Zijlstra wrote:
>> On Tue, Nov 19, 2024 at 04:35:00PM +0100, Valentin Schneider wrote:
>> 
>> > +void noinstr __flush_tlb_all_noinstr(void)
>> > +{
>> > +	/*
>> > +	 * This is for invocation in early entry code that cannot be
>> > +	 * instrumented. A RMW to CR4 works for most cases, but relies on
>> > +	 * being able to flip either of the PGE or PCIDE bits. Flipping CR4.PCID
>> > +	 * would require also resetting CR3.PCID, so just try with CR4.PGE, else
>> > +	 * do the CR3 write.
>> > +	 *
>> > +	 * XXX: this gives paravirt the finger.
>> > +	 */
>> > +	if (cpu_feature_enabled(X86_FEATURE_PGE))
>> > +		__native_tlb_flush_global_noinstr(this_cpu_read(cpu_tlbstate.cr4));
>> > +	else
>> > +		native_flush_tlb_local_noinstr();
>> > +}
>> 
>> Urgh, so that's a lot of ugleh, and cr4 has that pinning stuff and gah.
>> 
>> Why not always just do the CR3 write and call it a day? That should also
>> work for paravirt, no? Just make the whole write_cr3 thing noinstr and
>> voila.
>
> Oh gawd, just having looked at xen_write_cr3() this might not be
> entirely trivial to mark noinstr :/

... I hadn't even seen that.

AIUI the CR3 RMW is not "enough" if we have PGE enabled, because then
global pages aren't flushed.

The question becomes: what is held in global pages and do we care about
that when it comes to vmalloc()? I'm starting to think no, but this is x86,
I don't know what surprises are waiting for me.

I see e.g. ds_clear_cea() clears PTEs that can have the _PAGE_GLOBAL flag,
and it correctly uses the non-deferrable flush_tlb_kernel_range().


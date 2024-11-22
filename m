Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083917B4E9
	for <rcu@vger.kernel.org>; Fri, 22 Nov 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270667; cv=none; b=PGFa3Tvz683lx+lSVnMAjkll7i2wBP0bcuhONIcJ6EVZLmqfMZZdzD6zHybE6Pg+MuTmeIlDMePVesUR9bwn8ss5VKmy2iNA38gzlyw4wHRUC7gGZ8XGRIWt17wGm0faI5YvcPZPJ4j/PFRRfCQi9ZX16R07nyTYusOp37QIgrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270667; c=relaxed/simple;
	bh=XUuo/u7cK5K5gY/dFgAwCjVRAIBZqBeX+BIxJiAEQkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uYJY/MMo8JqtFU2w1pdWoKlwuZcc3GxCvDJBGvqlRpw03DZX7j4r42EZBQs5ykw3nzvOgUX/IcZnR9PyNhTUl+vKlkRibaJ6JZLqlrvZoxzJ3S2VkwQ8bo2bwbuTk2hdjD3zFj44v29Qt1IoMUshub6hCCGkfLl8+WbMP/y/YLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODvY3pyH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODvY3pyH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732270665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69DVKh9DUZx0Pn4NM7TlxBgCo8xRovdMM0JkhaNwI8A=;
	b=ODvY3pyHJMfA4P6Np7b49iS5zpeaNxVu2/tIID1WbyeFngJa0WZMhRifwNorVLRP8PEQhX
	TS+GuCoUWsl3QqTGmoLjXpB+0YKIS0d5ZVs7lSvDsg4T0ESxRwm2lOoauPkAMyMflTyGyV
	MQNn4tyD5/uL4x+PSqDwgb/rGMSR5v4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-6dSWrZctN4apSYcGhsvBLQ-1; Fri, 22 Nov 2024 05:17:43 -0500
X-MC-Unique: 6dSWrZctN4apSYcGhsvBLQ-1
X-Mimecast-MFC-AGG-ID: 6dSWrZctN4apSYcGhsvBLQ
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6eeb9152b2cso36457507b3.1
        for <rcu@vger.kernel.org>; Fri, 22 Nov 2024 02:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732270663; x=1732875463;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69DVKh9DUZx0Pn4NM7TlxBgCo8xRovdMM0JkhaNwI8A=;
        b=WtUoUoGcLCZSWZDDTIZyCAa3ZME4dlhO25ydouxx2VwU2Uz3KbDd7bZ0C2TMeTs337
         EBpHlluNujPS2c5omFQeipamQCYt2f5Xx6sTbw+E67Hi+l+NWlHXdh7rqFjQNdrkg9kB
         Sgvwnjt7vwzyEYRtMpL6NHj39Dh8SSJAbeCaSkMnkpYfQDMWLGE3EoeO7gKXXkzAu1MC
         cqCRTRLbmNuu3KfuYcPhXLmmzAC5PXGJEMnZTmg5WwaohPO0rpvX9y2sd0HEPupBsdLN
         ox5Cyvs7TDhYDj6m0wWg9vB2ZEDv8h4y9UdoNcnyg9vkCMjmTLl5Mn70aPdxEb1oWhW9
         fwpw==
X-Forwarded-Encrypted: i=1; AJvYcCV0sMzzHPw+a4QWapU5ms7TfBX4/RDajKkJzhkbMzbRU1edOAadKU5lsnT8c50XvXvDyeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTEUJL20z8MWk7cwqFmYRD9U242M7UyaHwqJ6IRZbd8iPlzU4r
	diLl0Xs7rC/75h8PirZbNuhV1NV0GUL6ORRxdqQdOeG4EHiohjcBRtGUtVUtyRr0oqHoEkHOo2K
	/hJopufteMLIdzn2mxyMN6spiSfe2M0Y0MC+uhTMoBFG0AV7l1g==
X-Gm-Gg: ASbGnctcjCIEjTisKWqP8HAU8ArhRkH5N982iQW1hBioO5QIaMiR/MH5zrdqmWPvZnF
	YVMl3pza72pX/fdwyG6ZH9FI/T2esiXs08HH/TQ5nDEz2gqgDeUsXPz0+hV86P7CkDcN0R6J9+V
	vmZWanxbOOE0sFcf4Tn3bTwU3khGrxq5tQcSbmSuqwsahvJSfRbAvKQzXdFl9W8ER3crk/5glPK
	msEyh9JHR5ogCL13cAEhd7cz4LhSw7kat22TQpMXw8k6B8t1ZrW2cFu6pO8H0U1e1koBY3Gh4ec
	/9ImUoJWFpMiA7i/8j7pfybJS0J3iPM9m/0=
X-Received: by 2002:a05:690c:4b8f:b0:6e2:a129:1623 with SMTP id 00721157ae682-6eee0a4e7cbmr23805887b3.38.1732270663060;
        Fri, 22 Nov 2024 02:17:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzjL7GOb26N8xVdZoDD0aeetdAAWaPf+1MRvyDFWpPzlOuVttoePPk8DAQ//wEdbZj+zzG2Q==
X-Received: by 2002:a05:690c:4b8f:b0:6e2:a129:1623 with SMTP id 00721157ae682-6eee0a4e7cbmr23805387b3.38.1732270662779;
        Fri, 22 Nov 2024 02:17:42 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513f91e8esm72637485a.2.2024.11.22.02.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:17:41 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Jason Baron <jbaron@akamai.com>, Kees Cook
 <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, Ard
 Biesheuvel <ardb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Juerg
 Haefliger <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Dan Carpenter <error27@gmail.com>,
 Chuang Wang <nashuiliang@gmail.com>, Yang Jihong <yangjihong1@huawei.com>,
 Petr Mladek <pmladek@suse.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Song Liu <song@kernel.org>, Julian Pidancet <julian.pidancet@oracle.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze
 <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Juri
 Lelli <juri.lelli@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Daniel Wagner <dwagner@suse.de>, Petr
 Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 06/15] jump_label: Add forceful jump label type
In-Reply-To: <20241121202106.nqybif4yru57wgu3@jpoimboe>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241119233902.kierxzg2aywpevqx@jpoimboe>
 <20241120145649.GJ19989@noisy.programming.kicks-ass.net>
 <20241120145746.GL38972@noisy.programming.kicks-ass.net>
 <20241120165515.qx4qyenlb5guvmfe@jpoimboe>
 <20241121110020.GC24774@noisy.programming.kicks-ass.net>
 <xhsmhcyioa8lu.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20241121202106.nqybif4yru57wgu3@jpoimboe>
Date: Fri, 22 Nov 2024 11:17:33 +0100
Message-ID: <xhsmha5dra7ya.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/11/24 12:21, Josh Poimboeuf wrote:
> On Thu, Nov 21, 2024 at 04:51:09PM +0100, Valentin Schneider wrote:
>> Okay so forcing the IPI for .noinstr patching lets us get rid of all the
>> force_ipi faff; however I would still want the special marking to tell
>> objtool "yep we're okay with this one", and still get warnings when a new
>> .noinstr key gets added so we double think about it.
>
> Yeah.  Though, instead of DECLARE_STATIC_KEY_FALSE_NOINSTR adding a new
> jump label type, it could just add an objtool annotation pointing to the
> key.  If that's the way we're going I could whip up a patch if that
> would help.
>

Well I'm down for the approach and I'd appreciate help for the objtool side
:-)

> --
> Josh


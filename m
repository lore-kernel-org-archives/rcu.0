Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B691876
	for <rcu@vger.kernel.org>; Tue, 19 Nov 2024 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732056720; cv=none; b=H41EaFfhTh/Zy/ovlnzCuAkQX4Dgzvq58JC79rS+CSZTn5BDsAqakFWF+bQnVQeik5a4t578J+Q//RP0iyfxp45xAe5ONtM6ObBU9aijt8p99p3P5sDOfwXx6W8lAUiMci4iRC4BY2PyGV0uIVEtIfhzz10tvtUbxCLveF5BVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732056720; c=relaxed/simple;
	bh=n+FUegK41l52wy6PHil3h7VNOwWht9pyTJK05iUwYtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tDfK788pE8PLKL0jTFqS+YQAR84XCW0GDTRxVktJCQIK0qoBd4jeBGxriEHoaCjHMj65Htf1Xo2gLTiFlOdFL/Hwk8ftqvDVtoG3/EStc5w2fS77fsedXBCwnd8FscphctbWA+Ogord2IN2ruUjRHoRThB/kD+GfYQFeKWo+4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOfWsLVH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOfWsLVH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732056717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0acvZIc1v1FoWClAO41Ko95c122YYqzO2aYK11MWEDA=;
	b=TOfWsLVHINq/FxbX9fEAK+rkGETCfXj9duKrLKrczjUbJI4HaH3BZEFaTDNivMLlzOHqLN
	/brrZ6XOCyKYLebZTl5s7I25MXTx5yBszjPtm3Q8RGI5VhggJTxyqZ+T3mqFwaGkUXenFQ
	br7fNlqvWaUNbYWS8HV1fLEXBI3JhnY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-INsRjXhdPxSyWiakRgqQVw-1; Tue, 19 Nov 2024 17:51:56 -0500
X-MC-Unique: INsRjXhdPxSyWiakRgqQVw-1
X-Mimecast-MFC-AGG-ID: INsRjXhdPxSyWiakRgqQVw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38243a4ba5fso2466474f8f.2
        for <rcu@vger.kernel.org>; Tue, 19 Nov 2024 14:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732056715; x=1732661515;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0acvZIc1v1FoWClAO41Ko95c122YYqzO2aYK11MWEDA=;
        b=KueGEOGbTcaZpaybzX6s8md8AyRbVi/STPGsJ2y9wKZD99VT6RTfZZtjsl+tNH7Mtm
         l4UkSaGXUABwe8Ug9wGsrQ+YzMxrislE/JoQ7TdkduKQc038B7ZuBX1auHzv0MV9B6y+
         oj6F5Q5kd8av1Xy1ki7hcCoh5RIqynn9BHkdyKOMPF9fzAyi8hKbqrWFrG4qUXZcKl9P
         5Cmk7LQBQ9ffWyrEa9tLeE6cCA+nStN9doQk9bz005xB6oHajNocVgeBEOYTTcG/+l8p
         +iJPv3T48ZFQLBBMvHhi9kO/J7avt7oip+XHRgQ2muA5aWLtaKFbk3XNdQeb1TDUqdze
         zC4g==
X-Forwarded-Encrypted: i=1; AJvYcCUi7UB1UklA/SBxjkSPq2Gme2IRWzHs3mXGiNHUtc8kbicHqSfSoYH1pTviipTH0TEVHK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywKPuC+zY2ckBCIZFWW1uc3jNAvOTx6eY0KBPxvpD66Cmuho3h
	N4FVE/SqHcISbTGXy5a1qYxRLOd2/bxiuPLiH1aZvtg5htkd50FSNBG4263BHAYiDq0A08Hg7ZD
	UnWVKEiHj8TAJ5mBc5sMT7kiJEb/F83NF6Yu4hS4SWGyNTBbDvA==
X-Received: by 2002:a05:600c:34c3:b0:42c:ba83:3f00 with SMTP id 5b1f17b1804b1-433489816d0mr4969495e9.1.1732056715548;
        Tue, 19 Nov 2024 14:51:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMYN+PGJWEPxaqNKkZYZ2TSeyMynnunVcMDwn9yZJBs1V5cl+I8e3VzKdyfOqsH7HbngJhGA==
X-Received: by 2002:a05:600c:34c3:b0:42c:ba83:3f00 with SMTP id 5b1f17b1804b1-433489816d0mr4969005e9.1.1732056715138;
        Tue, 19 Nov 2024 14:51:55 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27f4f8sm209297365e9.18.2024.11.19.14.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:51:54 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph
 Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Kees Cook
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
Subject: Re: [RFC PATCH v3 00/15] context_tracking,x86: Defer some IPIs
 until a user->kernel transition
In-Reply-To: <20241119114556.0949b562@gandalf.local.home>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119114556.0949b562@gandalf.local.home>
Date: Tue, 19 Nov 2024 23:51:52 +0100
Message-ID: <xhsmh8qtej0qf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/11/24 11:45, Steven Rostedt wrote:
> On Tue, 19 Nov 2024 16:34:47 +0100
> Valentin Schneider <vschneid@redhat.com> wrote:
>
>> Context
>> =======
>> 
>> We've observed within Red Hat that isolated, NOHZ_FULL CPUs running a
>> pure-userspace application get regularly interrupted by IPIs sent from
>> housekeeping CPUs. Those IPIs are caused by activity on the housekeeping CPUs
>> leading to various on_each_cpu() calls, e.g.:
>
> FYI,
>
> Sending a patch series at the start of the merge window is likely going to
> get ignored.
>
> Care to resend after rc1 is released? Or at least ping about it.
>

Heh, I was so far down "stop rewriting changelogs for the Nth time, get it
in a decent shape and send it out" that I forgot about this "small little
detail". Thanks for the reminder.


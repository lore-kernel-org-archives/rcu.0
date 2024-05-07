Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1F210E3
	for <rcu@vger.kernel.org>; Tue,  7 May 2024 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072388; cv=none; b=ASWNllPRuLjrvZcN70KO7r5tzrAT6V8AodFwkf1TVZ3EmuRj3RRsUkegF2IDLwKf9mhDIl4USesOsQ0GGr4GZbdWjJ7GGsYkigP4MrnTgtRdDwuUbSyxEwvIftF3F+mCGLNZKO2uf2PCLUMtjN+f8nvRReUVIxBQ7cBgXJ+UOgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072388; c=relaxed/simple;
	bh=ebNQ04II6wOZKST0CN9QD2/ZU/ttaRJ+uaw3WeYJASI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MF0p2Lr47uK4YibJf38VobnY+boEJkDLfphw1sEI02mNcKfK3UINN/BGdO5Byq5WLUKH1vskg82ycEM3npgZxGlmkkAAhdmziNufB5H6LDjY4fiEOJ/aQ28mtZunhhzxo7gKchaBJWym5WPS3Gr/8wAeVWFZs+zfYlP5OGFQfck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6UVgb6a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6UVgb6a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715072386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXg7vDSFLBXRnAZmKq2DFSdCCAuS4m+ghcizRtU/aIQ=;
	b=G6UVgb6ahW2W3AcFQh+hQ04XGq9W7s9A4H1ehQtCZJAWHT9EqtoAH+O8b3wf1kOyaV8rAC
	5YVATyzVKDYVamPJUyoEk1rkoVZKDKi7jdB2dqfpZkLloO6qYLuIK7MpTaOp6Jo6ScTgFj
	6bzq5uLC6nvRIt0kjev4Pr7/li+BwMU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-EocNQJDkPqC0IVxRaBkU3g-1; Tue, 07 May 2024 04:59:44 -0400
X-MC-Unique: EocNQJDkPqC0IVxRaBkU3g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41e9feb655eso8921395e9.1
        for <rcu@vger.kernel.org>; Tue, 07 May 2024 01:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715072383; x=1715677183;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXg7vDSFLBXRnAZmKq2DFSdCCAuS4m+ghcizRtU/aIQ=;
        b=e6/zMJYqYTktwdcPOGrW2fxKMu0zK0okhuD2kM/VYHmF5O2/bjcAbazARz6FFREXQ+
         2L0TRgsTJmXhSBWgnF1J92ZWO/d8HwimqMPXJnSe4LvuIEX3nSYyZiDpPUpMvny738d4
         dBHcLhlSThmL9DtTOu0jpSID73xG3b1IugI7rjESxzOiIBrqJ5+ycyd+jksvbKDQ6y8z
         957FENYb9Ws/s+d+0P2m/OeDhwUpamVMXvyOIwp9tsUObAtud6AHOZlROG+3LqkjUtuR
         c496s9p+70S/ANokf8ju23cKif6fh7jXmnwuiZrk3zep66BhTRkYF316TTkcOmIhSBb+
         oEaw==
X-Gm-Message-State: AOJu0YzJa6zQ/X+whxTX6V3z0ZPy0O1Z+fRtiiWuTcQpv4PRAqdxbRtd
	Udzi+WrZiDuA1443VRURSk4Hv/jXb5XUulapl2xqAj8XwDlndkg/rAy77qqE6LqxTy8XzJIhgSC
	4asMkw4aCFCTCYuJYr3YqLlJG8BWEr0rW8r5g2ep2pdpSfJwe0A==
X-Received: by 2002:a05:600c:1f95:b0:41b:b013:a2d8 with SMTP id je21-20020a05600c1f9500b0041bb013a2d8mr9301419wmb.10.1715072383423;
        Tue, 07 May 2024 01:59:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUTo0wqG8jU36Xt1dBDTv+19TLY9nO04Q1ZlAUSdnk0+uVkdZitidGdUYQbk2DEat9OMLp1w==
X-Received: by 2002:a05:600c:1f95:b0:41b:b013:a2d8 with SMTP id je21-20020a05600c1f9500b0041bb013a2d8mr9301400wmb.10.1715072382976;
        Tue, 07 May 2024 01:59:42 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c4e9400b0041b5500e438sm18939103wmq.23.2024.05.07.01.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 01:59:42 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 15/27] rcu: Rename rcu_dynticks_eqs_online() into
 rcu_watching_eqs_online()
In-Reply-To: <ZjlXLzjSKgXyI_7S@pavilion.home>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-16-vschneid@redhat.com>
 <ZjlXLzjSKgXyI_7S@pavilion.home>
Date: Tue, 07 May 2024 10:59:41 +0200
Message-ID: <xhsmha5l2hu9u.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/24 00:18, Frederic Weisbecker wrote:
> Le Tue, Apr 30, 2024 at 11:17:19AM +0200, Valentin Schneider a =C3=A9crit=
 :
>> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
>> RCU_WATCHING, reflect that change in the related helpers.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  kernel/rcu/tree.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index bb0d9dd8b6d3a..fe2beb7d2e82d 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -280,7 +280,7 @@ void rcu_softirq_qs(void)
>>  }
>>
>>  /*
>> - * Reset the current CPU's ->dynticks counter to indicate that the
>> + * Reset the current CPU's RCU_WATCHING counter to indicate that the
>>   * newly onlined CPU is no longer in an extended quiescent state.
>>   * This will either leave the counter unchanged, or increment it
>>   * to the next non-quiescent value.
>> @@ -289,7 +289,7 @@ void rcu_softirq_qs(void)
>>   * of the ->dynticks counter are manipulated only by the corresponding =
CPU,
>>   * or when the corresponding CPU is offline.
>>   */
>> -static void rcu_dynticks_eqs_online(void)
>> +static void rcu_watching_eqs_online(void)
>
> Or simply rcu_watching_online?
>

Myes, that's better. I went with keeping the "eqs" suffix for most of the
symbols, but I think here it can go.


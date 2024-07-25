Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D88512B7F
	for <rcu@vger.kernel.org>; Thu, 25 Jul 2024 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923676; cv=none; b=G7n5mdeES31PxLrShAlD1L4rS1AQ4ZCbgXC+I6s5dC3RElmY/ZSnRqtL3FFZ/mWWnp1heauU/lxwCyOIGlOwM94c16KxB2hR8MbOxXXBaSWDdlodB0iiwamWLfc1FvGhB/9Z2fpva43ETRXnKFU7y2CuYhyms4Dfrcu8ax3LFLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923676; c=relaxed/simple;
	bh=HX1DqGzOhxp/qoGBFu0letQeiiqLQQ3PtazzR6jqRqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c+UVXCMseO0p+kanOh5PK7XJD+CTRjpthDqyOzyyNMTgU6gsHVY0geDupVyyzzNchCx8O2O5NdwhzGkSIjs+cRVln4kAvAGIF4ZP8azthgMvavYd1f8oFifjNFownSWSSk6Hz1Glo2akqMlDeaMC+bK8Eui/H1wJ2en3MXAPoS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTgRSOFA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTgRSOFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721923674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HX1DqGzOhxp/qoGBFu0letQeiiqLQQ3PtazzR6jqRqQ=;
	b=hTgRSOFAbV6VoTsGA1ei47yBia5wh/GsBfwHPRKK9/ohBy7letBi3hq2vFJjoNIU2JWEwH
	/vGHqeqBbFOvaRhixUuPHS/cjIlls0D4yJVqifgWsbelWdKOPUVgmxPIuI/eqcirft0hUh
	zpsBb0EEiWp4CtQ64hj+MrMk92OMftU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-xus2C9FoNLGFEvCodLcd3Q-1; Thu, 25 Jul 2024 12:07:52 -0400
X-MC-Unique: xus2C9FoNLGFEvCodLcd3Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3687a1a6846so608401f8f.3
        for <rcu@vger.kernel.org>; Thu, 25 Jul 2024 09:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721923671; x=1722528471;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HX1DqGzOhxp/qoGBFu0letQeiiqLQQ3PtazzR6jqRqQ=;
        b=aLcmkqSIxKD+EefOAvwKr0KOEeTLED335RqhKVZd8CIo1cf6Juk2kHEeMLWnaVk7NL
         3LCOGWnGzzbmEtj/Ks/z5Q20IwFaXoP+ua9YzsL4fyOA0mtAIKoeAd4P10vL8I3xzdhV
         WXqIFMhgY6+j2GhkudLEGd2qW9h2tF8OPTl5OrkdVXkLuTb+/v6fnWCQYLug3XKa5bzq
         bbC5MKRdt4d66qoJvgHkwD6t9ISbVHIaWQKgGA808GKoUUf2KB5fbh8UVecGvVFmrWeA
         HQ1beyPdsB4JgmKag8pccSTHTAv+CaPsvX0m7OKMebXM1et6zzaIq8ECab3rlkxD4V7U
         3DpA==
X-Gm-Message-State: AOJu0YxbrfsW2+w7L9oFtlEX0uaj6AXK5D1HkyQUj81M0Wc02Gd2s/ZD
	IN+eC8KRbVhYLa2srVOd8dK6psWHqB50XGdzzkIF0Io+nUujUvF+78D3cfsVQujM8UqGkjAmjw+
	HXF4RHccCLQAMe7SVqogvySxVxcxnEPGWBr2V3lKzz3/tnfKaQg==
X-Received: by 2002:adf:e94a:0:b0:368:6633:c547 with SMTP id ffacd0b85a97d-36b31a12d14mr2146382f8f.37.1721923671358;
        Thu, 25 Jul 2024 09:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYK6ivvJkWkwIY3PX9kuYwoZq84Qv2MFI+lcEayNc1zjKj7tcG2Wz14ZdpaX1W8iVAY7kxUA==
X-Received: by 2002:adf:e94a:0:b0:368:6633:c547 with SMTP id ffacd0b85a97d-36b31a12d14mr2146368f8f.37.1721923671007;
        Thu, 25 Jul 2024 09:07:51 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d95c7sm2622945f8f.37.2024.07.25.09.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 09:07:50 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 00/25] context_tracking, rcu: Spring cleaning of
 dynticks references
In-Reply-To: <20240725152212.GA927726@neeraj.linux>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240725152212.GA927726@neeraj.linux>
Date: Thu, 25 Jul 2024 18:07:49 +0200
Message-ID: <xhsmh7cd9zc8a.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 25/07/24 20:52, Neeraj Upadhyay wrote:
> On Wed, Jul 24, 2024 at 04:43:00PM +0200, Valentin Schneider wrote:
>> Git info
>> ========
>>
>> The series is based on rcu/next at:
>> f395ae346be5 ("Merge branches 'doc.2024.06.06a', 'fixes.2024.06.06a', 'mb.2024.06.03a', 'nocb.2024.06.03a', 'rcu-tasks.2024.06.06a' and 'rcutorture.2024.06.06a' into HEAD")
>>
>
> Hi Valentin,
>
> I see that this series is based on paulmck/linux-rcu.git next branch,
> whereas the RCU tree has moved to shared tree now [1] and the next
> branch there is pulled for v6.11 (tag: rcu.2024.07.12a). I get merge
> conflicts while applying it. Can you please rebase?
>

My bad, thanks for pointing this out!


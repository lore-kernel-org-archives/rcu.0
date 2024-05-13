Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492EC4207A
	for <rcu@vger.kernel.org>; Mon, 13 May 2024 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625656; cv=none; b=eNHVzzNmQC1KRyR6AlPzvwkPVN9D4qT5I3R8vm0fwuhvNU/2NxRQH9kRVa+ubzvTirdAluXpAu/xifVD4WdgJKU284bSsj6vKwBiSUJHPFwJtnkItR+EVjbWjmOnrCHYpkJE6h9xX3i1dH4iuP4pLWOsPySBqGEDiZDzLEle8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625656; c=relaxed/simple;
	bh=SisZcXZqgcbTdXFFIU8xWo+kq/drZzZdUZzdlkD8UKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p+f7gf9jC0nHAWP5TCQ9zIz+JK9mymXR3y/daXdKOhQ+zgOeJPAIC3UZI2qwpw8Wp0Wd4WH80PlnnvMIYc6inL5zw5V85lBuhUpTbKrhCdTrlkTeuYcJSqgaOIob5to24mMmCFeRmrW1fFqnG3DPq73o2u03b3GfmoefWWbj1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBWX2YQV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBWX2YQV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715625654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVIn2rWOpVhbTil8h2wwg1NNh+EXi/kd2LlnyPlZrH8=;
	b=DBWX2YQVNVdawVqxwBGWkLbjX80B3UzS5kbado2h7eqjOdMd+MNbp+gPlvs16vdye+TH9r
	O+xgtopbp1qjE+MF4GTqIjulIcF9cWYGWyjkcE2rFTp5e+2KW68c4rpmSTZBieYcFQv1g0
	3c1VOZAuW/jfSC8YOs05B90bHx2UvZQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-SBXpoGJ1NsekoICLyX1jTg-1; Mon, 13 May 2024 14:40:48 -0400
X-MC-Unique: SBXpoGJ1NsekoICLyX1jTg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43d38a00d4fso65577871cf.1
        for <rcu@vger.kernel.org>; Mon, 13 May 2024 11:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715625646; x=1716230446;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVIn2rWOpVhbTil8h2wwg1NNh+EXi/kd2LlnyPlZrH8=;
        b=CGcTU6xO8Pfh0Bc0zsP8BXbEeJOAYMgw/R9j7O9DnQE434jOW9rVHbutkQ/eE9NR9S
         84/r6wDBtrH3V8cdSegwS74vpJbvHJct98u389E4Z1D3hkGvOgVSK8ED0RIQBW0JzJRg
         lFCenpzEZqHc65TqhQYRBuzCfWfm7u8SPBL0k7IaniLUvcpbNW/gywFhW66jHefTvkJD
         JC/3Xz5+LxBtbPxf+Yn/y9//jhHM1Acqco38rhSw4uTTJ6WsfbxY0l24PJyR356MRLPz
         uZgK0wSX2x77y31gbPvK1oz7FyTrH/ZCnHVczISwztt403otXMJxLt55C1yVHPy0Hj6W
         ku7A==
X-Gm-Message-State: AOJu0YzrlrywiExrQxENIWTq5yE8GTywnDjk8j5mPw369crm6i7K+k5a
	fxJXewZjD3THT562sDPVIZZD61JZPXGqAeGtS5pTb+TcnftzhIB+KVDc1O5PofoMSnGhOomKchg
	zSvk+fDWUUBqWl5NGuP+aAVw1+q64Kdpx85G7oQOuz38R4EGZPA==
X-Received: by 2002:ac8:7dd6:0:b0:43a:f7fb:bc4b with SMTP id d75a77b69052e-43dfdb0714amr109230491cf.14.1715625646274;
        Mon, 13 May 2024 11:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyEMwpDTnVPRtCr+Mg/v54BS100776/OI4rfOSjtaaCh2632huCZWaUGLfxNq0fFe9FHICXg==
X-Received: by 2002:ac8:7dd6:0:b0:43a:f7fb:bc4b with SMTP id d75a77b69052e-43dfdb0714amr109230311cf.14.1715625645923;
        Mon, 13 May 2024 11:40:45 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e1115dd3esm25071211cf.19.2024.05.13.11.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:40:45 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 27/27] context_tracking, rcu: Rename rcu_dyntick
 trace event into rcu_watching
In-Reply-To: <ZjuFUZXk4rYO4L2v@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-28-vschneid@redhat.com>
 <ZjuFUZXk4rYO4L2v@localhost.localdomain>
Date: Mon, 13 May 2024 20:40:42 +0200
Message-ID: <xhsmhr0e5h7x1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/05/24 15:59, Frederic Weisbecker wrote:
> Le Tue, Apr 30, 2024 at 11:17:31AM +0200, Valentin Schneider a =C3=A9crit=
 :
>> @@ -228,7 +228,7 @@ void noinstr ct_nmi_exit(void)
>>      }
>>
>>      /* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
>> -	trace_rcu_dyntick(TPS("Startirq"), ct_nmi_nesting(), 0, ct_rcu_watchin=
g());
>> +	trace_rcu_watching(TPS("Endirq"), ct_nmi_nesting(), 0, ct_rcu_watching=
());
>
> Ah the initial string was wrong and you're fixing it, right?
>
> Should be a seperate patch?
>

No, I'm just creating confusion for everyone involved (including myself) :(
Dynticks start when RCU stops watching, so the naming logic gets flipped on
its head.

If I take the original comment from
bd2b879a1ca5 ("rcu: Add tracing to irq/NMI dyntick-idle transitions")
"""
as argument: "Start" for entering dyntick-idle mode, "Startirq" for
entering it from irq/NMI
"""

So here "Startirq" means "start dyntick mode from IRQ". With the name
change, it should be "Endirq", since RCU stops watching, from IRQ...

I know, a lot of confusion for 0 functional change :(


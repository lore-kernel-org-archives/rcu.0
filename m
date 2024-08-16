Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929B617BED0
	for <rcu@vger.kernel.org>; Fri, 16 Aug 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803571; cv=none; b=ZuP7tONchC1gN8pGYaDW8Zr9M0GOCpXrUfSTo6FoBjGksBKyOV39yBNLMrQ3AV+dQIbpbMJGPTdLbAiccemdIMbPiEiyR4YHQ8Nw1i4yqU2DfbsyuqANathekMRcE2SdaoJp0GhNVMT11lsKXd+/VH3M5zfxKwDeQFrnEiEwEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803571; c=relaxed/simple;
	bh=WoDzLJGjLd7vC+WnknkQjgT7+H9CRmytRbPgbaD5W3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eaAE/GS/0FauySJ/qj92mSyM+7ezmV8ukwaOKCBGyDNMCbQIViozlMsRzzFnRQsd28oZnKFHqAQUJl9Q1dc8y55zMdmBTEsW/aDzdtH4+9kKNLXRhqfuxyHXxxOF6rdHCu28PqMkuVuwzoa3gdNeWbuJEdZF+Vcc21jry4SRbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrH3su0o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrH3su0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723803568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WoDzLJGjLd7vC+WnknkQjgT7+H9CRmytRbPgbaD5W3w=;
	b=VrH3su0o9EPn8Li4/+C+9NscvJw7uBGLfnGkcZuMLPNoejNxH++BRLBUPWHWs7cVdPubDy
	R23DvG2uQFqsSZ706iY2kCsbX1I5uk8ErAJY8zW1hCFh65xahiUxwgsY8bz/0Xmlb+KJAc
	d3sDwkCwH0fq9LhCvKzlVM0SNyl4ckU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-dov-9Iv3PgeUPvuHLwU4mA-1; Fri, 16 Aug 2024 06:19:27 -0400
X-MC-Unique: dov-9Iv3PgeUPvuHLwU4mA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3718baf35e0so766271f8f.1
        for <rcu@vger.kernel.org>; Fri, 16 Aug 2024 03:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723803566; x=1724408366;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoDzLJGjLd7vC+WnknkQjgT7+H9CRmytRbPgbaD5W3w=;
        b=UCvl4/CIh6HSdmfVVco8acxB1Xa1pvqvHr8Jy8pPpC17H2SI/0Xkn+WdUBt4qFXtWc
         dtydnqdFp37sOwidQOMIu0Ghweto5co+va4q4wqyBFoNZpqWoONfntVaKtS+On3+yNE7
         Ezk+HOQnFbsJkHx9nWahvdWQ9hntvaQuWJPGnk8ijb1gJnkFgLUGqNwMJgk77AN3D2ST
         V1RuR/E4S1E9cOoU70Wf6xswLVSNaBEaZz3j9lnwqC3RJOotatHwFsfZ+kZby3lSrs7G
         LFrnug6a4ggUIIn2eGq/TPFzHDVOf4YVV/NF9qKfCdHOS7dUK/rCSB3tjafHYOvgueau
         LWAA==
X-Gm-Message-State: AOJu0YxXEmLkPJccJA7Sk/ZOAlneLiFKM5sG1YqMnckCiMBhH8DVOmPo
	pf8iF8fV7e3eKrVAOoGsrVHqwCLVu4ueEWn/ZI7BvrhfsBg91VHC6a4XXSq0GyUQ3qApukLSXzS
	DRD+VHE8YWFrL+1LQ+1scR2OJtsqzdbWuma2MkRCw97vE1DFCP24/Ysim2Q==
X-Received: by 2002:adf:b1c8:0:b0:371:8682:467e with SMTP id ffacd0b85a97d-371946a50fdmr1256343f8f.46.1723803565931;
        Fri, 16 Aug 2024 03:19:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuJnhuI+vLEqELwsgHwcwqAmj2E/F4QMFHAmpwK5Hkye+NXTlsDqPHLLrs3goEqNA35dX/+g==
X-Received: by 2002:adf:b1c8:0:b0:371:8682:467e with SMTP id ffacd0b85a97d-371946a50fdmr1256316f8f.46.1723803565156;
        Fri, 16 Aug 2024 03:19:25 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aa229sm3299709f8f.88.2024.08.16.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:19:24 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 13/25] context_tracking, rcu: Rename
 rcu_dynticks_task*() into rcu_task*()
In-Reply-To: <20240814120655.GA1412760@neeraj.linux>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-14-vschneid@redhat.com>
 <ZqphRBrI4mlSdER4@localhost.localdomain>
 <20240814120655.GA1412760@neeraj.linux>
Date: Fri, 16 Aug 2024 12:19:23 +0200
Message-ID: <xhsmhbk1sdb2s.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/08/24 17:36, Neeraj Upadhyay wrote:
>
> I have updated it here [1]. Please let me know if something looks
> incorrect.
>
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/commit/?h=next.14.08.24a&id=cfc22b9f1572b137dd9f36da831dd7b69c9fe352
>
> - Neeraj

LGTM, thank you for making the changes!


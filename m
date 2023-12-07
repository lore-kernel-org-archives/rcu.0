Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="pMnlYoYB"
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320BD10FC
	for <rcu@vger.kernel.org>; Thu,  7 Dec 2023 09:20:36 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c2a444311so9650135e9.2
        for <rcu@vger.kernel.org>; Thu, 07 Dec 2023 09:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701969634; x=1702574434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJZmz+Xu31RsK3yOUZORHxWDqDtm9lOUD8SdzkJgnz0=;
        b=pMnlYoYBy+mj2rR3/EpiYBOyI5lboZ9sN1UVqJqvK1tCZNObhLFt+HC3VPjwwyHH1n
         zVPApKrWTNhwC0QkXHqALz4UDUt5g83S0lyqkwb4QvUURp3j+FhOkT0Y4rD+IFo1QVat
         rt/y3aMsqp72tCBxnVIDCgIxoI6p+1geAXDLYDcoEVO8+xUn7pPALt1mSkZO6qTF1RzP
         sS6MtiKVzfNp27bLqyejx2bagwN124HFxiVADW7KQ5QVhGCuSmHns++jWXlm/mA5d1TT
         9MHf+btuiuCxjULGDUmdw9YyZ+FKmSp9SBNpG2V5CasvWGG9vedneau/4YG+Fz5BDmnM
         KGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969634; x=1702574434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJZmz+Xu31RsK3yOUZORHxWDqDtm9lOUD8SdzkJgnz0=;
        b=qr5n0APezrK3Rn+EN7gmY8f9vsIgGe6y4WIGVRIvzjJz+ZDwLiGpwG9yNhiJt0Vuxz
         V+SnXPeoDud1zmLmZUD+5X74Rnzn5r5OePD5P5kGkaQlmvs3VJ6hMCt03YstZTaBTq8C
         ISqQdXUS4PUUTEBnx2Zy76S+bdKDsk8wnkR9bZxvZMKiCrrQILf/svm73k396i/fbHE/
         H4CXIlsn3uR7F9PuftW6XrX3NDA6Z0bv1rxqKACLz3Vh2tRKZDuLrWu2ZkWmTOIKvwPv
         nUA+G4c9oEwtfH+xjNEHe+6XSgf2KQh9h/W1+hTQDbMLw1MCv8CwCWa9OR41jecYszsX
         uR7A==
X-Gm-Message-State: AOJu0YwzShb2UkUdXa2AMzIyWrE4ZQFZ+lF0cI7HsGDrj5RGcP64iEdK
	drlELWAL+0LoTZPxyTLnpD0MWA==
X-Google-Smtp-Source: AGHT+IHBoX8I60F64oLKl/3IeE8m25oA1jeZ3zTmZ1x7KOkD6L2XcMtJGWBkxLiOkWToPoUqFUixhw==
X-Received: by 2002:a05:600c:6009:b0:40c:251a:101a with SMTP id az9-20020a05600c600900b0040c251a101amr697747wmb.311.1701969634537;
        Thu, 07 Dec 2023 09:20:34 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id bd19-20020a05600c1f1300b0040839fcb217sm318562wmb.8.2023.12.07.09.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:20:34 -0800 (PST)
Date: Thu, 7 Dec 2023 17:20:32 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
Message-ID: <20231207172032.kto27hfdxa4juq7b@airbuntu>
References: <20231203011252.233748-1-qyousef@layalina.io>
 <20231205162043.GA2558193@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205162043.GA2558193@google.com>

On 12/05/23 16:20, Joel Fernandes wrote:

> I think a better approach is not do an anti-CONFIG option and instead do
> a shorter parameter "rcutree.lazy=0". If CONFIG_RCU_LAZY is set, then we can
> just default to keeping lazy on. I'd like to avoid proliferation of already
> large number of RCU config options and more chances of errors.

The issue is that we don't want to ship with default on :-)

> I also want lazy to be ON for everybody configuring it into the kernel by
> default (those who don't want it just set CONFIG_RCU_LAZY=n), this is what

This is still the default behavior.

And all or nothing approach is not practical. You're telling me if I can't ship
with default off, then I must disable it altogether. Adoption will become
harder IMHO.

> tglx also suggested that's why we made changed of our initial prototypes of
> call_rcu_lazy() and instead we made call_rcu() to put everyone on the lazy
> train and not add more APIs (thus causing more confusion to kernel
> developers). This was a bit painful, but it was worth it.

I think implementation details make sense, but orthogonal to the problem of
enabling CONFIG_RCU_LAZY=y but still ship with default off. It is a risky
change and we want to start staging with default off first. Not allowing this
in upstream means I'll either have to resort to keep it disabled, or carry out
of tree patch to get what I want. Both of which would be unfortunate.


Thanks!

--
Qais Yousef

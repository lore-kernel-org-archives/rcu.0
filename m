Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MZq5jTgV"
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F12010D2
	for <rcu@vger.kernel.org>; Fri,  8 Dec 2023 22:26:32 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77f3c4914e5so134635485a.3
        for <rcu@vger.kernel.org>; Fri, 08 Dec 2023 22:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702103191; x=1702707991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGEqRbAOqRDZpXV3cM8EuFLtIYKbtDmEW5PqabCIpAE=;
        b=MZq5jTgVRTRSPm3zRY4rft+fJRk2xCHY19K6F7t2gL/RFh4wmcqtJfjyK2aS1ZOYBW
         QUGL8BU78j6BnrsmL/bTLfodSHpIFW63qRrllfV6ShR6qfZzR8R0SKc/p7Za2mK1K8h6
         rkp/ndLAMS2CkUSkzS5BqzI2cyzzcP2K1wwI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702103191; x=1702707991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGEqRbAOqRDZpXV3cM8EuFLtIYKbtDmEW5PqabCIpAE=;
        b=QRZxc+ET2hd3KqlX/Pqe6fz23U1AZxp6ZC+DJuwAjIunOMvb45b0HNiCSEsr2vfVqv
         R2OsLUpwYBksCMAnB2EBpnfbmIS295IxZoWaib/Bmo8ZxNr+wgyqaDkAlbOWnIXhmWd5
         oz0E+M5cwvOga93VmaKSqm5qbDHg/3/Oce5tAMufNKTg/Jir1WH94Qt4gptVRA9DOlOO
         2oCC5Q2WhLjtRD2S1mgiRu4cWV4WDv1G1fw0c0hyk5UCPqjIrCv+zqtNzXojX5U7mRRk
         gxWOM5YMMZRTHu4miSN1zAy1n4TShXRogmtCDE+gz6Z0arcWe4lkq3RjDgMNog+CfWnr
         Ygcw==
X-Gm-Message-State: AOJu0YzV7Xrk1mWFRZugS+axJ94U4RZc6TXypcf1oGMzajDoamW1NJ6X
	d000lE4haJw59x0Phdvvp0P6GQ==
X-Google-Smtp-Source: AGHT+IEfmFqu5X1I7POQ6eMTDP02vZ0lPLNqpg+VRe6aWHQnfAy9uIrcy9YbOSXaWuirdwtTFLv3PA==
X-Received: by 2002:ae9:c013:0:b0:77f:395c:3794 with SMTP id u19-20020ae9c013000000b0077f395c3794mr1423302qkk.106.1702103191221;
        Fri, 08 Dec 2023 22:26:31 -0800 (PST)
Received: from [100.115.92.196] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id tn24-20020a05620a3c1800b0077f052fa73bsm1227929qkn.15.2023.12.08.22.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 22:26:30 -0800 (PST)
Message-ID: <0d531690-1240-4356-a647-b4c71a56b31d@joelfernandes.org>
Date: Sat, 9 Dec 2023 01:26:27 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Andrea Righi <andrea.righi@canonical.com>, John Stultz <jstultz@google.com>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org
References: <20231203011252.233748-1-qyousef@layalina.io>
 <20231205162043.GA2558193@google.com>
 <20231207172032.kto27hfdxa4juq7b@airbuntu>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20231207172032.kto27hfdxa4juq7b@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 12:20, Qais Yousef wrote:
> On 12/05/23 16:20, Joel Fernandes wrote:
> 
>> I think a better approach is not do an anti-CONFIG option and instead do
>> a shorter parameter "rcutree.lazy=0". If CONFIG_RCU_LAZY is set, then we can
>> just default to keeping lazy on. I'd like to avoid proliferation of already
>> large number of RCU config options and more chances of errors.
> 
> The issue is that we don't want to ship with default on :-)

Yes, so you can ship with rcutree.enable_lazy=0 which this patch adds, no? In
theory, you can accomplish this by simply CONFIG_RCU_LAZY=y and
rcutree.enable_lazy=0 or rcutree.lazy=0.

However, I see the inconvenience factor (you have to set a boot parameter
without making this a purely .config affair) so I am not terribly opposed with
this patch (I am also guilty of adding a CONFIG option to avoid having to set a
boot parameter (for unrelated feature), but in my defense I did not know a boot
parameter existed for the said feature). ;-)

>> I also want lazy to be ON for everybody configuring it into the kernel by
>> default (those who don't want it just set CONFIG_RCU_LAZY=n), this is what
> 
> This is still the default behavior.
> 
> And all or nothing approach is not practical. You're telling me if I can't ship
> with default off, then I must disable it altogether. Adoption will become
> harder IMHO.

No, that's not what I said. You misunderstood me (which is probably my fault at
not being more clear). It is not all or nothing. I am just saying you can
accomplish "default off" by just setting the boot parameter. With this patch,
you are not willing to do that out of convenience, which I can understand but
still we should at least have a discussion about that.

> 
>> tglx also suggested that's why we made changed of our initial prototypes of
>> call_rcu_lazy() and instead we made call_rcu() to put everyone on the lazy
>> train and not add more APIs (thus causing more confusion to kernel
>> developers). This was a bit painful, but it was worth it.
> 
> I think implementation details make sense, but orthogonal to the problem of
> enabling CONFIG_RCU_LAZY=y but still ship with default off. It is a risky
> change and we want to start staging with default off first.

Never had any issue with that. I very much want to see this safely rolled out to
Android. ;-)

> Not allowing this
> in upstream means I'll either have to resort to keep it disabled, or carry out
> of tree patch to get what I want. Both of which would be unfortunate.

There is already precedent for building things into the kernel but keeping them
default off, so I don't have an issue with the experimentation use case. I was
just discussing whether the additional CONFIG is really needed when you already
have added a boot param to keep it default-off. If you have an argument for why
that would be really helpful [1].

Also, nit: rcutree.enable_lazy is probably better than rcutree.enable_rcu_lazy.
The 'rcu' is redundant.

Other than that, the patch LGTM but if you could update the commit log with
details about [1], that would be great. And while at it, you could add my tag:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


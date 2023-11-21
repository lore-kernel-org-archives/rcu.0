Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="ADTOikpD"
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C272CD40
	for <rcu@vger.kernel.org>; Thu, 23 Nov 2023 05:23:03 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c8879a1570so11085081fa.1
        for <rcu@vger.kernel.org>; Thu, 23 Nov 2023 05:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700745782; x=1701350582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fmeSlyRRAZmkiADOOVUeH9QDd85AntrliLGP54hloZQ=;
        b=ADTOikpDonUTGJzYT3drdkqttCmqLQ03H+ys9gu/Ec1wVH0tKjd3w45LQos2oceeZG
         8PPFkrhWgFJJoUp9uBV3yo1tTXGDITUwAmIXHqemNBp4GVxHXo+I/o3HBYhj45BYNq1P
         FuSJPV+0GUuSCfYz750+xZQTFybs5VyNWvPhQOnD6FAXxSjV4lN03EC5Cymkhl32fx0K
         cFGYDkuC5R7xBlrwhQqg1z3DUu4CObHW/dLMI7D3QpdehYHcmlAYZD5iYgXyCSRqWK52
         omFbPEbZmiGLWL5Korm0WPFs1OAPNnOkPu99OaP+7m6VYuFb608uXyZzo/Q/M608ZiKl
         INcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700745782; x=1701350582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmeSlyRRAZmkiADOOVUeH9QDd85AntrliLGP54hloZQ=;
        b=DByPAN5SC4GeDeGi5EhxsHN0ZMH/rkpQgdnl+900d6202yIlVwIdfSsvyZG7KRN9Rl
         2T9eoZeYwO6is2UAPOJw7lWPo54qDCtAJTKi/eHa0NUe8+m6+/A3ZmF9P8Q8W2CrKl9q
         LjjcrxStSt9h2q3nDzxcX6FuMUmSdv5+DfRNVD20zRlr+VaKUXiZCAMBaumVHrEqCRPx
         gb/Ckvxf89NMeSw0dteN0uEQ42OxmCSpddtN1vp76OBxhfaz7RZCxF2flfG87j0cp85y
         iFasFHre32KrMufY7lwLTvJ2f5nAC4iN95euW+4RgTmxGphE4RIrd2Q9pI6Y9uZVz8iW
         2LwQ==
X-Gm-Message-State: AOJu0YyxCRqemk3rMU349lm6I0AjeoDAC1jpgFG3zTrZyIPVcsqd84cf
	C3CarFPhVO7tRIQwu+PSBNawSg==
X-Google-Smtp-Source: AGHT+IGFgp4TppLOoOOJ7pc4hl+TCahn+25qfWriVz63S8qOwrN2mC+tDrckfI9n2PiK0T1LH8PoBA==
X-Received: by 2002:a2e:920b:0:b0:2c5:23e3:ed11 with SMTP id k11-20020a2e920b000000b002c523e3ed11mr4198294ljg.30.1700745781933;
        Thu, 23 Nov 2023 05:23:01 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b004076f522058sm2738021wms.0.2023.11.23.05.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:23:01 -0800 (PST)
Date: Tue, 21 Nov 2023 22:17:52 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Provide a boot time parameter to enable lazy RCU
Message-ID: <20231121221752.wphdk3xqgoii6eub@airbuntu>
References: <20231121205304.315146-1-qyousef@layalina.io>
 <ZV7xIjSq1l1q7gRI@gpd>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV7xIjSq1l1q7gRI@gpd>

On 11/23/23 07:28, Andrea Righi wrote:
> On Tue, Nov 21, 2023 at 08:53:04PM +0000, Qais Yousef wrote:
> > To allow more flexible opt-in arrangements while still provide a single
> > kernel for distros, provide a boot time parameter to enable lazy RCU.
> > 
> > Specify:
> > 
> > 	rcutree.enable_rcu_lazy
> > 
> > Which also requires
> > 
> > 	rcu_nocbs=all
> > 
> > at boot time to enable lazy RCU assuming CONFIG_RCU_LAZY=y. The
> > parameter will be ignored if CONFIG_RCU_LAZY is not set.
> > 
> > With this change now lazy RCU is disabled by default if the boot
> > parameter is not set even when CONFIG_RCU_LAZY is enabled.
> 
> I'm wondering if we should make this enabled by default if
> CONFIG_RCU_LAZY=y, so we don't break the previous behavior, and those
> who want it disabled (despite having CONFIG_RCU_LAZY=y in their .config)
> can add rcutree.enable_rcu_lazy=0 to the boot options.
> 
> Thanks for working on this!

Sure, thanks for having a look!

Cheers

--
Qais Yousef

Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4304014EC62;
	Wed, 26 Feb 2025 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604390; cv=none; b=gO1f5yMkn9EG1LP3/Rgjm13ueULRzELy3YdYlrKxzfxGbFyvkOEXBE1HWNbWIwrV0bDdmnmGMmRs0B35ujemn55VH0Z+azgqKiYmD/OPpwN4khIyen098v2vjxRxuS51ryWHyIyRtzBX6Cpan66U+IM/eGNl6FUCNaykzlYTu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604390; c=relaxed/simple;
	bh=r6ctwvTBzCOsJfegDA3zEy2JPkq7n4u0xEqH/cdj0gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrFRTf0h4cbWGozpTuVEunv/Ck4Xn9j/LJDIIKA5zX87vtewQKHMdD6tdfgOwltpimHTpsm6Dg8IqhZz+aGINjF8MlKci7OxcZ7Cu2dVl09xQBLfRVPqukRv5M2FQS/195Kn5+c+NMkQboTQyBIPsoBIsbJiUq6ewjvRdDair9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evORnxZS; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evORnxZS"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c095b5365eso17027985a.1;
        Wed, 26 Feb 2025 13:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740604388; x=1741209188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuhPUiiWa/D5LUXBpWxpkn8zHplSC1iuiAYg+ApjZbg=;
        b=evORnxZS7fbuViQRID4WeDtEklP6m9d3hEk1eYiX23LBIWpy2AwKVI7rpWB/wejske
         ZkU2MAMP+W2+60yKnE2j3tEhvVmj0hAS0XCKkQH+WdS+5WSt1QXNuDqpUlZOsP4U6q/G
         EdTs0jRLHov7KAexj3zvFkVb5H8cH8CAG6Fi6dg1Us0ElN08FFHizG6L38e7P0aJKjdZ
         5b8Soiep/S36Y5cjQZBy8M/7OgGQdws8y27JrszmHZQX3Jp4nwXGnpsov0vPO2F5Uqio
         WXEBsRjQW3l5S2HzN4HEA4p20QOKmL7rAkVGxLwRVbHNdoJNTpOKAcKSJS0hcWs3hTsx
         Ulrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604388; x=1741209188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuhPUiiWa/D5LUXBpWxpkn8zHplSC1iuiAYg+ApjZbg=;
        b=Tltd3Wy2KiyHzVZ7jKnhrXMS/Vb/PKVrsMmkQEvFGBLw3UYlHr/sjcOaKXo3Bn/PaP
         s+5JhuFJYWqjsSsZUeNsl4ulFtQBUx143TqNpPZCcih9RtJH2YjNqbUWxklu/JIKx8rk
         Lm5gH2tk8wo8NVUdQrYRaLEBIVBiHmgwjUGCE5UeZhDfCa4xqK/riw0Fg+hN3/lYBU4i
         HcFtbUgPF07xTc0J0+DnuIH70Vcn6gnStiMA8GwJg5XT2whFpNHEX+u9Xjyj4Vz1W3C6
         yT1jWI2s1LB/0kGltajg6xRUSQ+K/kLDNAekc4PyBHLWVqP/Ay81CHbk7H3e7Pszg5F3
         mggw==
X-Forwarded-Encrypted: i=1; AJvYcCUpOl5HEVxtYaipv+b5soAH0UIAgcY0EWd4shakQ39VLixl6PQewyMgOugidjVyZ8jGYLluz9/BIjcFWD4=@vger.kernel.org, AJvYcCXyD37TxqKGuD9BdQlRzXqMVMX71OlZxA4QJSu2vA7HCdq3IqVnouwxf8xUeeAL49FYoM5X@vger.kernel.org
X-Gm-Message-State: AOJu0YzCON1DATtbzICH7E7ZXSTFwMc2RAeFW5lda9lKrlAdsbZmxUVy
	NALUBsFQCYJN4HougLCPIe8+62fJV8L9X/JOR3ExpOssdig/sMjY
X-Gm-Gg: ASbGncsRk0i52ACW8mq6A4Iho7F89cFk928bkCfim1FXdoHADZb7BSF84+t0JtKn6dQ
	n4ytNR0peBry20VBxweypS8DNdj7vEXTS1a45GB2MCgeXOPJrji1F5DfcSE6NtxNzFRe5RJTiBz
	6GnoD+IZd/GvjaPM5PIGyCHn4Cs/B5nwRuJg2YmpuMZ/6U/fTAWeoldxS6qw7MHKaorjVJqAjeP
	PCZX3Pl/3vlZrjapCEesxWIVUu4RCdTVX8Zpj5pEgBQsqHG6ec7rIjNHp9emGP+Crq8FlH1B1Dm
	BGdgmalLOylCHFbO0qP26JHPpHayOSqH49MckerWmcz0GZ2aPlXazyT1EaRjtYV6OVO4ENO5NY/
	WoVp/nh1iE20Buw4s
X-Google-Smtp-Source: AGHT+IEea6S8UsN+IOEXDInlJY7lKrtjGxkFo0CVKQOzJ0kf+D6eZ4hlGIfyjtlTD09u8q1SSQQy9Q==
X-Received: by 2002:a05:620a:3183:b0:7c0:a216:404f with SMTP id af79cd13be357-7c247f00dcbmr525241985a.2.1740604388075;
        Wed, 26 Feb 2025 13:13:08 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976d9f19sm745166d6.98.2025.02.26.13.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 13:13:07 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2ABB81200070;
	Wed, 26 Feb 2025 16:13:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 26 Feb 2025 16:13:07 -0500
X-ME-Sender: <xms:44O_Z7JMCCWCYoVdBER2fUw2kOlvtjnbYphna5qMDF-TXHYy_f67yA>
    <xme:44O_Z_KvfpGDU5-c_jPSmFUEdSw-PiFzvxf5QCBd1T4zVHt_Og5auVzY1GN4-6LKU
    _Xry9KXUXevaL15Fg>
X-ME-Received: <xmr:44O_ZzuufMt98zu-Su_2psDXHe_FfXz7jlUbXoUbGHIuHWyeRZrKDt1K7yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgt
    uhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepiiiiqhhqtddutdefrdhhvgihsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhiesrghmugdrtgho
    mhdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrghdprhgtph
    htthhopeholhgvkhhsihihrdgrvhhrrghmtghhvghnkhhosehsohhnhidrtghomh
X-ME-Proxy: <xmx:44O_Z0ad5rXhxJFn_NG1HDA_AWHLm4kj_e8U9A84-5AUZ_Qu19z_Sg>
    <xmx:44O_ZyafSZFFMjiHDur1tcK4mBfEeqpmZMv1rG7jI5eGFMZdTzNi_w>
    <xmx:44O_Z4CDQy1pa_0wwtCz_mS1TB8xEMgb4D_r3xo9XlvaKPWcj_PiaA>
    <xmx:44O_ZwaPgZrrYw20yaQOjGpwmVEA4jMuMXkWOKo4InC4iPWGaIEgyw>
    <xmx:44O_Z2oW4kU8FzFzGDopJsxTm_57RQKs014UlFW652psAJxxS2N3S0BO>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 16:13:06 -0500 (EST)
Date: Wed, 26 Feb 2025 13:12:21 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z7-DtSTSXOETcrnD@boqun-archlinux>
References: <20250225110020.59221-1-urezki@gmail.com>
 <20250225110020.59221-3-urezki@gmail.com>
 <Z79kKiokpq9FpjYc@boqun-archlinux>
 <Z79-NAOoK-Vimgbr@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z79-NAOoK-Vimgbr@pc636>

On Wed, Feb 26, 2025 at 09:48:52PM +0100, Uladzislau Rezki wrote:
> Hello, Boqun.
> 
> > Hi Ulad,
> > 
> > On Tue, Feb 25, 2025 at 12:00:20PM +0100, Uladzislau Rezki (Sony) wrote:
> > > Switch for using of get_state_synchronize_rcu_full() and
> > > poll_state_synchronize_rcu_full() pair for debug a normal
> > > synchronize_rcu() call.
> > > 
> > > Just using "not" full APIs to identify if a grace period
> > > is passed or not might lead to a false kernel splat.
> > > 
> > 
> > Could you provide detailed explanation on this? I.e. why is _full() is
> > needed? I find the current commit message is a bit vague.
> >
> <snip>
> rcu: Use _full() API to debug synchronize_rcu()
> 
> Switch for using of get_state_synchronize_rcu_full() and
> poll_state_synchronize_rcu_full() pair to debug a normal
> synchronize_rcu() call.
> 
> Just using "not" full APIs to identify if a grace period is
> passed or not might lead to a false-positive kernel splat.
> 
> It can happen, because get_state_synchronize_rcu() compresses
> both normal and expedited states into one single unsigned long
> value, so a poll_state_synchronize_rcu() can miss GP-completion
> when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> run.
> 
> To address this, switch to poll_state_synchronize_rcu_full() and
> get_state_synchronize_rcu_full() APIs, which use separate variables
> for expedited and normal states.
> <snip>
> 
> Does it look better?
> 

Yes, that looks good to me. Thanks!

Regards,
Boqun

> --
> Uladzislau Rezki
> 

Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0EA156F2B;
	Wed, 22 Jan 2025 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545289; cv=none; b=AeVteLs+M8R0BZqbrzxHbiDk+/WtWcqNsK4jiigE/8g6mo/iygQaofhwma2oJWRhQcbi0AP8BbQY7qD6tvb8HO9JcqAO7SBt3ykOtdd1d/hGgljnzAwcfd4j2KfErPusp86zVcisZVVhI9SHq+4LlhZ2D/Gua7JOrhB2g6W/c88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545289; c=relaxed/simple;
	bh=Y1P2PPk5qq/ESRqLrVJiAlhxL3nYYN+LN1tcDPdObMs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoIwuF4ZKHpZQ4/KZK60dfcT8eG6slyAz+ImQsapNPLePE2hLTam4MGobNq2lWxAuxM1vuVLjYMxiI9wWI5AtFbVGk345hcg2becgiVunp6zeClIKwX1IrL/ilP6cb+i9bJ7v4MSmI8bBNiTkN9VgdQP2g7p/ijBLd5DeUSCnOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu2px04V; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu2px04V"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-304e4562516so8162991fa.1;
        Wed, 22 Jan 2025 03:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737545284; x=1738150084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PENNKJQUdjBmRpPlKC+RgEY3XDyecWwCTHL3ABZIA1A=;
        b=hu2px04VzdSo2+RLmZ7vLaJIWN63tvYU9zS8WEuUBhq1T5n/ePIJweNGbRIw7TnZ7h
         6ptI0ERr+Do8sT62RH6+UPOCAuRuC2QCd6/ITNKML8f64EY/P7OPxczakUwNbzIO+d2Y
         9FuOGi63bh7oXxRBIFT1QXeTJtaa34Du9t9F+bXMXCkjR2LC5wYWBNi8lCJrh7GfGEtI
         0UFdtKHoEEcv1M+mZgPnE8iyEXI7/YsuCmHcxwaNSB1977vpNrVvj54VDQe2PE7cZXXw
         SGly4M1KKcjCZKzFljQq3urYSU7ttkjsVWkKOFMRAMYF8MTtrUH43VqFd+zqs9hX8va5
         YsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737545284; x=1738150084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PENNKJQUdjBmRpPlKC+RgEY3XDyecWwCTHL3ABZIA1A=;
        b=eqLiAcOev1vLT2NRY03mtH9gENz0RZrBiiITvhop9PDyXGXDl7deVtbtA/1xugU6r0
         ZRdgtFqVSK8wV0W3giMCXz56oQaZZ9BIgA3c56JOdpZoNUB/Pj+akXveu97LZ754htmj
         /fEShRYdbSmQWT8MuUy0Ip5z882ZqXJiidm+Cfyij5yEXvvntOu8Awem5Nm//3v3Kw9d
         IC2/FmqzXO5B1G1VffI6yR3ynNl6fOA0uiJ9/PCtsNofuMiM9mHYsOf6qb7C2fZiS33J
         /mGFrCPAMMc3z0gAxY14W4YPONimOS63viOB6fCkxOBInBmvcZzUiiJc7QPKNGtG9Vgz
         jBEg==
X-Forwarded-Encrypted: i=1; AJvYcCVpsYiBY+o8qY5UIBe5M2qSzAFNPpCSC2nieVqNz3eW7AnVM4Dq3y3J68AZ+LjifcaV3Lnw@vger.kernel.org, AJvYcCXgKNZIscH6qD/3BjhgetPcoCBTo4ydTcX/+GBgvyRHivMOCCBel6kUojji1GTAEZxV5CwDXiOjklen14Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mvl7Uhu7hsKShjTOSf0LbHABO/CSmlD+sQ/xIm1OmYlZ6pd7
	WhSOcEbQh36l4D6fmnFoXfCJXeCdhmbG4dMo6xSXFBMFH7CnUMRM
X-Gm-Gg: ASbGncvdLdvfR9KGw8GY53QzXC8vRYzF8MIvFQL8Z1Ob+ntfZmUeb4XibteUnC8pE+K
	pwI52p+9ZVQ/OZ9C+7BqYd0TzPIGs9Vcp2FdkcNtrIS0BMvXAr5uxXW3JmwZ795AV14UIhFCnKR
	2yqXO3QdBmAHOfPWB+tyNe2knKven67wofTPzhXGk9gvqxXg28Bu5Q0UFj9qrgALrfMVdARZDco
	aDEowOTSwrqyhaHAYHHEnQiG9NYOj7RSrnxKTOjlhlGw+7OqpLBx6GPGZweBlle1+z6HIma+ngn
	RC1X6DyBJqKG0cGTpM9ClIV7
X-Google-Smtp-Source: AGHT+IEfTb3OnseDPnu7N8MbZB5bwBSepJNhD6UWzckfvdJcEosABtWGVlEOh6z70oSV24A/GLnVRQ==
X-Received: by 2002:a2e:a4c4:0:b0:2ff:b8f5:5a17 with SMTP id 38308e7fff4ca-3072d0e5928mr63352381fa.5.1737545284195;
        Wed, 22 Jan 2025 03:28:04 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3072a35b893sm25839311fa.63.2025.01.22.03.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:28:03 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 22 Jan 2025 12:28:00 +0100
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Feng Lee <379943137@qq.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [GIT PULL] RCU changes for v6.14
Message-ID: <Z5DWQHUxpUpwd7W-@pc636>
References: <20250117172440.49319-1-urezki@gmail.com>
 <CAHk-=wgGjEgK3V6XtGckJ5gdPsoj5Zn4O+ipN6Kvv83AKE2h9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgGjEgK3V6XtGckJ5gdPsoj5Zn4O+ipN6Kvv83AKE2h9Q@mail.gmail.com>

On Tue, Jan 21, 2025 at 02:51:15PM -0800, Linus Torvalds wrote:
> On Fri, 17 Jan 2025 at 09:24, Uladzislau Rezki (Sony) <urezki@gmail.com> wrote:
> >
> > Please pull the latest RCU git tree from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.14
> 
> Hmm. I have pulled this, and the resulting shortlog matches what you
> say I should have gotten.
> 
> But your diffstat is odd and looks very wrong.
> 
> Things like this:
> 
> >  tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c |  395 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> were already in my tree from before, and aren't new (and your shortlog
> doesn't mention them).
> 
> Also, look at that line. It's long. It's not supposed to be that long.
> You've presumably generated this (incorrect) diffstat in a very wide
> terminal, and then cut-and-pasted that very wide output into the
> email.
> 
> Please don't do that. Yes, git will default to wide output if the
> output is a wide terminal, but if you either pipe it into something
> else (may I suggest "xsel", so that it goes directly into your X
> clipboard).
> 
> Or use "--stat=80" to limit the width manually to 80 columns.
> 
> But the strange formatting is the less worrisome issue. The diffstat
> just being plain wrong is the more alarming thing.
>
Thank you for taking this in!

My script that generates a diff-stat is not perfect, i will fix it.
Sorry this is my bad.

--
Uladzislau Rezki

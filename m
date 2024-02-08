Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294F692F6
	for <rcu@vger.kernel.org>; Thu,  8 Feb 2024 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375346; cv=none; b=gbE5GUhy3RfgNFYPbeDnYRsodxGSkyhn7GrPHNa8dceTb+Yq0eJR/S88uJPBOaoWMhPpxi3N8QREo+YuGJfOGSQxC9V2c1pMuQ3fedKsx2QbnTvptWk1yG/3kJPo2uJcjiTQY0WVj1MkHokW+OLwavmIqfvkSbEfA+FBh7WkJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375346; c=relaxed/simple;
	bh=79WpyWFhhwnITEYtrDRh2HuYoUTo8Gp1thZC7OtSQf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMDHvRgnf7BLvSGljveNZvB6WbT0prvYCTuqkuJGIOvJqqMY8NW1KbeYn2N3e6y8uXIBRhGqLbXhiHLUjCcDrfgeYb3L2BI0Ib6HlAzmT+JFcSK1GQIz/N57NOYmwdqWosDoEefcl/ppAITLcWjW1/ckW9bD7B6yoIX+RefdIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nQ+JMiEY; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nQ+JMiEY"
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D95073F17F
	for <rcu@vger.kernel.org>; Thu,  8 Feb 2024 06:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707375340;
	bh=KaI9SPFYFsVtfK3ZxuJTH7t7un2FToL+0f8QUJjNCZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=nQ+JMiEYlMs5E/9nE0BLpdNqFkqqpiNmdLrZHAdvCYRaevJODp/2PVuc6q5rPZKKf
	 zMf8zS1UbrBUye4O6KkzxBL+i7Ls7Cg66JO9RDDUYS5ubppGwg9sPttfjZhHGwdD8f
	 STn03l/o3WnjqgnEMqCGe06oOiSRohHfNwQR4Hz9ss9HQcSUJ6Ic+N7JbV/aOY1/mI
	 VpFZ96zZRDC4aHmN2Mj4syc+K+06OOlVpWRb3T5tW3ouCJi31IRfH4e1lLgOJED1sJ
	 Ye4hJl5ApU8QWuAyTl0e3mZQeYySVUnCHiC3A6PtMj8J/H1Nok0/W36LqOj9uKatOI
	 1sipy7H7+uXdQ==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51147e15397so1435522e87.3
        for <rcu@vger.kernel.org>; Wed, 07 Feb 2024 22:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707375340; x=1707980140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaI9SPFYFsVtfK3ZxuJTH7t7un2FToL+0f8QUJjNCZo=;
        b=qGDNMWVs75jjGGzzk4BM3NDTZS8BC/8/GmkbUZbfJQ7klGAD+EjLAjOQ36KV218sDT
         HKlyYFqCcMtZxy4csO3jBI85R8dpkpmT78FfzFm52/w9XSPlvbl4JNV4RLRp+8O9R/mr
         oHV05iCVHK7M9/kwZfdikraVCCMgZhkyFW+0/n4YutZdkAGebnPGwvjmWTkO8dKwYPkD
         Gxyy83ENRHjL0H1KmOO+rPT9QCvs4nhUWXy20dMrAdT9wUg71QZNmYk4wvFNYShWthLj
         TwO93fHGBO8V2HQnbiZCKIyXs4gTn1WupKkd6aTTMPugRuFDgETiX0toCeUl2Yp6VZtw
         Qf0A==
X-Gm-Message-State: AOJu0YyCKz3Td9k0tNPhPan+iCiaXJ7snYKWquPKi5yhbzXNarUqaiAs
	/wemj3KEvc8ZJnHBNQICrlkAnLEguwDRqTUPao+DoTxoykTR0LbAieUMGa63GiuYcNageJQ6+nW
	cpE/zpc4jw1q/0FFLCwI887pIgbUffYnFk7DFVvPItvxGlgXUKINpri/b1dT4mUy6qyMszZ0rsA
	==
X-Received: by 2002:a05:6512:33cc:b0:511:4e6a:52fd with SMTP id d12-20020a05651233cc00b005114e6a52fdmr6806618lfg.3.1707375340231;
        Wed, 07 Feb 2024 22:55:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfD98wSgjcgNS/8mAwtto5q8epEaJGi99hGGkvIaImRNLPKKTUkRX4aY4pxbwsgW5SMJNnIw==
X-Received: by 2002:a05:6512:33cc:b0:511:4e6a:52fd with SMTP id d12-20020a05651233cc00b005114e6a52fdmr6806606lfg.3.1707375339844;
        Wed, 07 Feb 2024 22:55:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdjMKxvemBrLJZNXeym/RpLoYaaqONDSVanuHPPGu781iekr+hX1xU+6Gx8ky5w8dKn7x+QQYA0n3igtwAf2ehfSUc6gJq+5Sw4qB8frQPA7MhyOlRKQNfmH6UbJLSIX8daANyr1ADu203Lt8Ff1jAdFaCNggkEA8DrfQr
Received: from localhost (host-79-53-78-93.retail.telecomitalia.it. [79.53.78.93])
        by smtp.gmail.com with ESMTPSA id g26-20020a170906395a00b00a38103ab710sm1566021eje.125.2024.02.07.22.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 22:55:39 -0800 (PST)
Date: Thu, 8 Feb 2024 07:55:37 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <ZcR66cxax008lPGv@gpd>
References: <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636>
 <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
 <ZcJxhoNpkTM7LnOr@gpd>
 <9f9b6885-6d9d-4f30-9635-49443e1615e9@joelfernandes.org>
 <ZcOwRsEhbQhGv9X2@gpd>
 <CAEXW_YQN=Dm4TXv+F=Q4bfnKWn1Tv52=8hz50JLkbufcM5hUpQ@mail.gmail.com>
 <ZcO4c6nxemyxRFz3@gpd>
 <1fcf7e8a-c245-4c5c-ac86-7f0a1531032d@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fcf7e8a-c245-4c5c-ac86-7f0a1531032d@joelfernandes.org>

On Thu, Feb 08, 2024 at 12:54:58AM -0500, Joel Fernandes wrote:
...
> >> Slightly related, but one of the things we are wondering also is how
> >> much of the overhead for your nohz-full and lazy-RCU test (on top of
> >> baseline - that is just CONFIG_HZ=1000 without nohz-full or nocbs) is
> >> because of just using NOCB. Uladsizlau mentioned he might run a test
> >> for comparing along those lines as well.
> > 
> > Just to clarify, "lazy rcu on" results are just with rcu_nocb=all and
> > lazy RCUs enabled (and HZ=1000), so without nohz_full.
> > 
> > If I enable only nohz_full=all (without rcu_nocb) I see something like
> > this:
> 
> Ok. I did want to mention nohz_full implies rcu_nocb on the same CPUs as well.
> 
> Its also mentioned in the boot param docs on the last line of the description:
> 
>         nohz_full=      [KNL,BOOT,SMP,ISOL]
>                         The argument is a cpu list, as described above.
>                         In kernels built with CONFIG_NO_HZ_FULL=y, set
>                         the specified list of CPUs whose tick will be stopped
>                         whenever possible. The boot CPU will be forced outside
>                         the range to maintain the timekeeping.  Any CPUs
>                         in this list will have their RCU callbacks offloaded,
>                         just as if they had also been called out in the
>                         rcu_nocbs= boot parameter.

Ah I didn't realize that, it definitely makes sense, thanks for
clarifying it.

Then basically in the results that I posted the difference is
"nohz_full=all+rcu_nocb=all" vs "rcu_nocb=all+lazy_RCU=on".

> 
> (btw, I am a bit slow to respond to email due to being ill).

Get well soon!

> 
> thanks,
> 
>  - Joel

-Andrea

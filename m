Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8EA1E495;
	Fri, 24 Jan 2025 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737718905; cv=none; b=juC4ZD+NmnXhskDgHjnJVP2NPUdwP6kSMq0AiwijRg8gZjtFHtBDPNoRZjPoorevMmLICp0C/RuTv6kae5HGD2dc2SGQ9zVPbSHutNbVh/zFdWkcQtjjCmgLu9WZeMRED4MSkWUmU57ETmX2Q2MVvsUwVNnvxepnUleYX8g132U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737718905; c=relaxed/simple;
	bh=cMIitP4XmQY7dALjBOjVawerA+npBn/hshRxCeYiza4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8Rl+DHoSjI4v2tdyauZvryE6Pg2xnjrtC2pbycCaCeMZBKoi+9yRpNZYZ7HXq58zaBZjopalwDn2hhsp0ZE2MIsHrG6pbpRoc6R5y7TLmmb03bQAxA2HKNIQib2gips/MMINcOUJD7EqeKj3mk97DFuTYGKTGv3KM/khSaqaXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVuJCZv8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVuJCZv8"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53df80eeeedso2205587e87.2;
        Fri, 24 Jan 2025 03:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737718902; x=1738323702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NS/G2aM1NLkBuUdo/HVV2lGZqUmriSmC/xeGCNPwjng=;
        b=NVuJCZv8IK/IyfkXI3g3c1qDg2XLTFPr8ynA9ERCbwyMueyDMIXg2YuHBUm6AaTOX1
         DHLlMiIvXU19wdkGy4FFB9c5O/CZfNP7syT316srpm9B1yZjxkWecyq9rS71aJRDMkzI
         NEdKdGmMTOnLHye6FNml+s2tLDuIDy3sgJSAHAcWLGPYK24nrsd+lCuPBFgIXf3Lzfl5
         iCEbTrBO4t6LQAhtbF3tRKAknPzNeVmgcZP1Q+bzHR26N3cUhVs0YZ7rc+Gh64q3E037
         3LMgF2TvJxEmQo3hCNBx9M13+bgiGuJ1nVC/3kC+1md6iUv5J6S1fUywJOqIP4G0ahyv
         TTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737718902; x=1738323702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS/G2aM1NLkBuUdo/HVV2lGZqUmriSmC/xeGCNPwjng=;
        b=uOM0LPkwmhx2tcpxaf3rRkX45Yse02NqGAe53ovNoYU+qm8c9eua5CdZ6pyV8nNtmh
         wGJ9RbyySGJ2E0d/apKi5fhqHMVM4BCJwQ8pq+FqE0VUClTUFH+J1xYnktBX2Fk5CCcG
         rYu83xFLdpgv+3bQLK/8Jyd6YtFzfVRowrBX0WR70sn5IK5osZbpmO6w+q++vc5d/W36
         im+unh+xRy7Hlo76Abacy0MzW4eEtbXyFJf8b8X6DFJfro7uUPUKweW6+9LNLDOf8w/C
         Ceu40uZAzFBdIQyoRG50+ixYIrnn846XG16kMnloRBJqT7s3VGvzhte3w6mt10wfh7bv
         SS9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUg7ljWl+FQn87YCgw+PZwcsFV1N3ZnB+lGRWAecurDTCvg1OYamECduEj3Rxk6ewMtm41CWUd7kmpHdGw=@vger.kernel.org, AJvYcCXeZc/GW1K/+979S/EOQsJqTgp6/d5JcfFFjbcnszJvBMVho02+N0W2yZOMWeY+vnG0479C@vger.kernel.org
X-Gm-Message-State: AOJu0YxV7Q6EIbcmYBW1qVAQMrFUp2T2VPIn6Xb7ja/OvoFyiECX7PZQ
	9ZfiiamvW3imCuvFWAqw842LgYDdrvxHqw6eB+/Jcc0K75mCkv1URXRakg==
X-Gm-Gg: ASbGnctFhAqJllah62ad64dbCWLuBvYwaYkQDmq2bgQQEPeBTr87g8LrhLGeNtZXMSA
	bg59F0sCOeviI+1c5ET68rEgUSUjaab7e24LN3JK6uaRGwLRftwCklxuzd/koJElWN2peGHmGU5
	GceDJbHm+zgnzQQ6PLfNp/1aGng132YxrJpCSTmAJd6UwcHqliAPDMkTBixPx70VMxSYDaT6dMH
	ptlokNVGGT4CjrCEMvqc8hrAMh531pNUa0ieRmAllAWQVfdViWNFPbmKNL6Lkrecb1csSenY740
	fwp+KLVKJHNe8neFfq+cTbmJ6CQZ7ybDR+M=
X-Google-Smtp-Source: AGHT+IHJjIBDttTSiJA5HqBau7qSBpwUHKyNh03pJxjkHNWtizkGnV+CbA17aYGyl8wYjpQY49nFjw==
X-Received: by 2002:a05:6512:e83:b0:542:2991:e984 with SMTP id 2adb3069b0e04-5439c21f2a4mr8986286e87.9.1737718901520;
        Fri, 24 Jan 2025 03:41:41 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8379b76sm269121e87.172.2025.01.24.03.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:41:40 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 24 Jan 2025 12:41:38 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <Z5N8cmpD-HmTYQQJ@pc636>
References: <20250123185828.460836-1-urezki@gmail.com>
 <20250123185828.460836-2-urezki@gmail.com>
 <6f2969e3-344d-4f2d-a71c-ed999ac35324@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f2969e3-344d-4f2d-a71c-ed999ac35324@paulmck-laptop>

On Thu, Jan 23, 2025 at 12:29:45PM -0800, Paul E. McKenney wrote:
> On Thu, Jan 23, 2025 at 07:58:26PM +0100, Uladzislau Rezki (Sony) wrote:
> > This configuration specifies the maximum number of CPUs which
> > is set to 8. The problem is that it can not be overwritten for
> > something higher.
> > 
> > Remove that configuration for TREE05, so it is possible to run
> > the torture test on as many CPUs as many system has.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> You should be able to override this on the kvm.sh command line by
> specifying "--kconfig CONFIG_NR_CPUS=128" or whatever number you wish.
> For example, see the torture.sh querying the system's number of CPUs
> and then specifying it to a number of tests.
> 
> Or am I missing something here?
> 
It took me a while to understand what happens. Apparently there is this
8 CPUs limitation. Yes, i can do it manually by passing --kconfig but
you need to know about that. I have not expected that.

Therefore i removed it from the configuration because i have not found
a good explanation why we need. It is confusing instead :)

--
Uladzislau Rezki

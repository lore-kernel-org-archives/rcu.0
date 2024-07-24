Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D10125D5;
	Wed, 24 Jul 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831023; cv=none; b=m6Disf7kKFZz43k4qQrGxXTmfD6MauGcXm0p+6slMfR1jJokG7yQH9ve79tuakxGx6kVsEmuHWFi8tKtcFuYLuMmbFBwB14oe4fvs2smBNDVjtI43F00vYjHj2ICM10R9vM10Hxv1A/uTJt/ZlVHxmuTDgRTO1YcAKmSsCo+qPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831023; c=relaxed/simple;
	bh=o1vyCWrOEnJSPhQeQwYVvcXBz00MEc+qFETtadk9VSI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsNf58gacYCaL0GTOwj//RID0TdDooMTcAMoOioEqZH/61KZITRVh4P21+xq6O9efXbwM7ccbhRotSCTZhk1iCCDOaT+5CHPZP0VouywJiPMUgbafDDC3oxvRYMoUfMUUPKZmmTrENVo6R0Q16kq8ECpMgIxs2DT84ekEH0Aqz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoG5ea6g; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoG5ea6g"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f04c29588so5039672e87.3;
        Wed, 24 Jul 2024 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721831020; x=1722435820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2EYPtwVexQejWeBwfrFohRS5AiySF5QR+M7wRajTBb4=;
        b=hoG5ea6g9sd/S+wokS/B+SXiBqyKD/gPg++dMVIVOLd5JElxPnN+jcKphn5o2Wo9xi
         gf4et5eeLibE+VN/P0gX/KMRQKUcpJz1qSPlpDLGzVGx0QcMOUC0FpUwGruumV7jrSVP
         vrHihGdYZy5Jina26AuYWjsnvJ7VQw5YsStCuFueEaUwZ753S30vtbEXCb/IQDugZ6+e
         qfOCn8N2HI1MSAx5Xyq6VnifIrDYCNL7c6yMyahWlADMx26FgtJTylUDf+EUTSdQsQJc
         JJSnHGX9ugewNX3ti/k44GkrpIIU+Y8jVQM5TlaqRz9AZmDuz3fclOOHdwKdQJ3JnQdc
         k4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721831020; x=1722435820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EYPtwVexQejWeBwfrFohRS5AiySF5QR+M7wRajTBb4=;
        b=D6aie0+JCCyysjl80W17bN9UnDJZw5i4cqVV8Zl1OK6ivDByoV6DvuQdFJkDXG4RXU
         6ZCiHoIRt9krrWp1zupwjUkvWGCYyr/w+S2nQo/LzqBpoYvyiQ8hkTJtSwBcLDobABZy
         Sp5ZalCba47LY7MLgon7Apy98NZHxHN/lil+brBltTB8SO9d/xncmXkA4Nm2nG8uC17Y
         MmSMKH0+LEMHfsdc0bM/r8havyVZlhlWKYMTC4N/QEkJiUzD2vLcJ3orgtOwLbXYkBTR
         idvx4DZYf6pNpNyD5K9ekNWv54uaswmqbmisCoMTJ5cczGdgmdyme9R8zkMt3xk5v3wk
         3xog==
X-Forwarded-Encrypted: i=1; AJvYcCW1KzCp1vpb4nim8vyCAljSCQX772fPsNiH7Im1CLgTMupu+ACnVgRJM36dgsGZ0EQOoH9EDgTWDoLYCbQ2Q1OkxMl7Ph9NV4rte2MTmiA971LPAC6Qh1E1cpkHn7pE9Lau
X-Gm-Message-State: AOJu0YyRS7UgDXozbWHgfce1+4P5cgPZy0IaCLh0Hi1SbOnYAdcg5od9
	6xrr8oMDRRC+l7QllCgClWOxYOXjZaeRWqjWtLRo6Ma33nNCw4vG
X-Google-Smtp-Source: AGHT+IG6ntjpOTXF57UPyAUAZr4QB0ucUAojjGteAmif46ElLDnmFJ9mX0p+f502h0znfQmncnAgpA==
X-Received: by 2002:ac2:4e05:0:b0:52e:9e53:6ccb with SMTP id 2adb3069b0e04-52efb7942c1mr8453657e87.17.1721831018239;
        Wed, 24 Jul 2024 07:23:38 -0700 (PDT)
Received: from pc636 (host-90-233-213-186.mobileonline.telia.com. [90.233.213.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52f0046ed98sm1366708e87.187.2024.07.24.07.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 07:23:37 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 24 Jul 2024 16:23:35 +0200
To: Breno Leitao <leitao@debian.org>
Cc: Waiman Long <longman@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vratislav Bendel <vbendel@redhat.com>
Subject: Re: [PATCH] rcu: Use system_unbound_wq to avoid disturbing isolated
 CPUs
Message-ID: <ZqEOZ8qPf1sadzB_@pc636>
References: <20240723181025.187413-1-longman@redhat.com>
 <ZqEB9Yz0womtmDRg@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqEB9Yz0womtmDRg@gmail.com>

On Wed, Jul 24, 2024 at 06:30:29AM -0700, Breno Leitao wrote:
> On Tue, Jul 23, 2024 at 02:10:25PM -0400, Waiman Long wrote:
> > It was discovered that isolated CPUs could sometimes be disturbed by
> > kworkers processing kfree_rcu() works causing higher than expected
> > latency. It is because the RCU core uses "system_wq" which doesn't have
> > the WQ_UNBOUND flag to handle all its work items. Fix this violation of
> > latency limits by using "system_unbound_wq" in the RCU core instead.
> > This will ensure that those work items will not be run on CPUs marked
> > as isolated.
> > 
> > Beside the WQ_UNBOUND flag, the other major difference between system_wq
> > and system_unbound_wq is their max_active count. The system_unbound_wq
> > has a max_active of WQ_MAX_ACTIVE (512) while system_wq's max_active
> > is WQ_DFL_ACTIVE (256) which is half of WQ_MAX_ACTIVE.
> > 
> > Reported-by: Vratislav Bendel <vbendel@redhat.com>
> 
> I've seen this problem a while ago and reported to the list:
> 
> 	https://lore.kernel.org/all/Zp906X7VJGNKl5fW@gmail.com/
> 
> I've just applied this test, and run my workload for 2 hours without
> hitting this issue. Thanks for solving it.
> 
> Tested-by: Breno Leitao <leitao@debian.org>
>
Thank you for testing this! I saw your recent email about that :)

--
Uladzislau Rezki

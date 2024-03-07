Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA413C6BA
	for <rcu@vger.kernel.org>; Thu,  7 Mar 2024 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709855554; cv=none; b=GNr//qqiGQVMcOpIbwWQkvf2XtGjMWIie74biwAEduQnOYWUHU4V/DFip0cybkgdqimNkl1indAQ+KmtlD+Fj/oNH8sddMEm4M8b5Qdd5IC5icvl0+tqIDdAFqhG9EYiYVkcbQefF+Fzkz3XfvXdcykqc0/y31B9PeW2zGP6s8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709855554; c=relaxed/simple;
	bh=rrrE288GGqnOFkITVQ6l8vfzosgPyL+5gwpnGsNXtEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hEifRjr/Dc7TBg/zP6qqyYRdinZSDnm9P5VVSdRTUO8HZE6aa1u2V4RtnEsrVjRj8itDhfGNFO/QzrrZeI6c7DGG+hkAKv7QK03tF3xnP/HRE77LuCtxpwplxtpBX/y//k7KYFcmKN0UQT4bvS4I1aGBNSF7Qk97E3MJo7bqFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=EhekeZZx; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EhekeZZx"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d269dc3575so14137551fa.1
        for <rcu@vger.kernel.org>; Thu, 07 Mar 2024 15:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709855550; x=1710460350; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrrE288GGqnOFkITVQ6l8vfzosgPyL+5gwpnGsNXtEM=;
        b=EhekeZZx7ulzJXjlimX6cE7fVhGadcX+0+4wdR20hGsgBQbolvBe808ru1HQwlhFZ5
         5v4/pFYBRZwas2MBdP6YMDU8r6/0SfztFwnfsFZFu5u9AWEfM7CLHMwvkU4aGiU/P5ZC
         qxG4uUJyBLQ3QulPBIgLr2geOy3d8N9URj5tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709855550; x=1710460350;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrrE288GGqnOFkITVQ6l8vfzosgPyL+5gwpnGsNXtEM=;
        b=J+QUYyITWS3Q72pDkk5wqshLordzvmmEcYN5ONytc+wo45lfr/UO5X2GqDaYlyGdQJ
         CptJI3qCoRp++0EapS1GRIA+4PdSqK98oUFRwp4AdsuBPlXjETplQCe3eIZPypq8Hj6j
         hVBQtsnQpn7/dLJUG9fCxcfl5sgoWL8cIXYLeyIDbr2Iz1qfxwGZm9jWQZNfaQgjVZwz
         5neAnrJ4+YG2N3029KHWiGCrMh+3DuDMEDAcbZuvp+HkgSeVwogDn46M2gCcu6HDIXLh
         +2IjxTUvFd8PCsmFWBKqJepHbnLevmJGbEHj/eta/CxFB1W3Dv8bZxOWM2sqcNQi/6Ze
         xT8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhtWBgfQLPUbUEohYBTTG6SuFYVRHAFglemMmaozsHsfIdGiyVqVhVUZz5+zAmI2ZKMVygy3uEtwkRWBlmPNJGtOBi
X-Gm-Message-State: AOJu0YyGAhJWP/HojqHLsNQH+hguJbMQjVps4+PzChunncmvcOmB7MKf
	HqWO//yuzGLhCy7Osov8y/XgWolx+OOd9qf4AHr+8F15qIF71LT68SOJQ5eXhyQZZZJta4d44VL
	jX+tJ4KUrMEjC2O1Jjf7hatNZCJjoCZ7OIwgFNw==
X-Google-Smtp-Source: AGHT+IGwE8AFVxTKrwVEKeSVNA5fVRjhIMcv4GE0U3qh32bzUdIr8/Jz4yM8wQjU8QgMQHPbiKJux0YVFsOIeFz0iFI=
X-Received: by 2002:a2e:7809:0:b0:2d3:ed17:1f53 with SMTP id
 t9-20020a2e7809000000b002d3ed171f53mr1154509ljc.19.1709855549963; Thu, 07 Mar
 2024 15:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307234852.2132637-1-joel@joelfernandes.org>
In-Reply-To: <20240307234852.2132637-1-joel@joelfernandes.org>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 7 Mar 2024 18:52:14 -0500
Message-ID: <CAEXW_YQ-TZB-1gpxvf7v+QAZhHtzV5waBA1VemtgEwNktSp=ww@mail.gmail.com>
Subject: Re: [PATCH] [RFC] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
To: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com, 
	urezki@gmail.com, neeraj.iitr10@gmail.com, joel@joelfernandes.org, 
	rcu@vger.kernel.org, rostedt@goodmis.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 6:48=E2=80=AFPM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> In the synchronize_rcu() common case, we will have less than
> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> is pointless just to free the last injected wait head since at that point=
,
> all the users have already been awakened.
>
> Introduce a new counter to track this and prevent the wakeup in the
> common case.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---

Forgot to mention, this is based on the latest RCU -dev branch and
passes light rcutorture testing on all configs. Heavier rcutorture
testing (60 minutes) was performed on TREE03.

Thanks.

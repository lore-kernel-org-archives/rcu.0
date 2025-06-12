Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB6838B;
	Thu, 12 Jun 2025 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749750380; cv=none; b=VnmWqciUTH6vDaij83FhR52ZDuc4w6Nzj/xlQlbxlLwpPt/seBGEyjxiYbfyjn0JRX/tHEXmwriZAuQsMoKj3/cnv69FxPelXgEVYJ+rt7U1sAaGCVPyhUK+8xEH6OVcmhy2Jb18B9I1q2gYdmpyl8xfHSl3f+sPV9cd/MjD8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749750380; c=relaxed/simple;
	bh=21WuvrE1X3trk287V3DrJa6NKcmuKe5icltvLlC8sM8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PW45BhAfAIAm1ijtVX3nxSiiFF8ou32M/lNExQK0ogf1zi9XO+KTNQYp4RE3i/Y/pJ70mUk8VWH4caEiV3Xim9Hc8FQOH86DiNXG5KwosyZ4LgMHULA0f/xZM9Bpj72xUKLQgftL1QPNMMdkr05GVsg5udPv5SS6QTN34AhuWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es62Chpm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es62Chpm"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55220699ba8so1335951e87.2;
        Thu, 12 Jun 2025 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749750377; x=1750355177; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aJyXy9pxvVxSP5k59NygtSiv9DiWthCoWbffsOf+IxI=;
        b=Es62Chpm2JPKM7lPthIRcBLFnnftb7gwxK1g43YMUaWtSo6voeqRROx5d5OTYgnkoa
         81gp/2WERoZ7tBQY31GfXU86F9cpDNqyZpvI1MAjP8oFc/lLbTwXI9T3zo1lex6c8n5h
         xaAW+CYovZmXAa6TvmIVdQLvF/PWSS/7OVIqWAiG5l7oWqFURDeReV+JuI+Hy9RU7F4r
         CwKnFm2m/yrqI+V0TgxWD9+hsdoBH4B4/Pz4mwgL1zp89eRw0mtbT1FohKK2xawMM3ud
         hDNHQZdQmwfWkJ8fYKu31R1Sk91CCxe9ZPQX7X3VYblJ1CyJgi+PebYXckyD1EJV75QO
         nr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749750377; x=1750355177;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJyXy9pxvVxSP5k59NygtSiv9DiWthCoWbffsOf+IxI=;
        b=RC+9M2PLJ2HBVuXZs1nmgOTOWBTpPqCJhUN0U5fFjqghlpmqiDH/CLLj0s2Y9/8GHn
         9m8Lpwozd8h4fKzXfz3LKiGxab30efugxrCxA3jSHte3BntlvTHGzlYrruZooItAkMup
         ham3NIQd12JzSbjG9oLZBa8MNmrTMbWtMz2FX8HQ6Rsw271Eupiuw/J+NMW+fIPbm3xs
         MvixkOlKTsXt/TfsqTVFlOSLyBCtz/TBH6Pr1+4WXxDW7Zx2Qgqx50dngO8J/c+8Uh/5
         rSYPQeXhjEUdm36bkTWJJ0NwjQgKL2xFvTRGYhAGsTcVR8uRFYShnCmaoY4EsMm7axoF
         xgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV78V4/JZB2K9HZMF8kZsxR/rnb+0qr07ZBoQtNbfqOdqHfLWnNg3dKQcHM/s3BVTEn/iBBjX50SLfMIL0=@vger.kernel.org, AJvYcCXXxHYPVwzPiX8W1zwVUFRhJ/ZnkM2QZ/a8LlcElz59t3mxvc8SAYtRLGZgAsn8h1PgyZRG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Wker9aUgTtk7GosoXtJiE1EmifPhwbh4wK3aokpoQUZy58oH
	I1i4alG6w1NXOoHjdwgiJjLbfl6k15mPtbOvYAMw+CyV1yWILvcOksWP
X-Gm-Gg: ASbGnctUGlEB6vfxD+WnHYsdHueBsobzfS6tDUUkUGvhtg+881Z9tymG+jXwnqsRu2U
	k8TAHiHfBcfwWdRzfU+1dQDgUnbvoHayrqwdQpfYbrEwZkcKPtTCBOhB0X90qGHFfObEWNaT9l6
	SLpe6EW9dz86Xomfx5WKucEc1nu8NPJQir9KxaQm6oMa10NFKZPoCp0985zxHEnGu3dtjOVho++
	iZmZ27h8bc9Ajl9H8252VuhOrnkSRqG3KmwT/+L7qLc8HU3glIwfIo8cJi4iXcIawFFFFYIMvTX
	fhVx8TbE8iZlf9D+DFtYNIOAsCE9SJkiDtr8JRlZIff2/8nY/wbLLOxflPNtg6Eqsbtu8YKTXCl
	BFsaGt/h6Zzo=
X-Google-Smtp-Source: AGHT+IEOLs0ANK0wIjBQ0PWafYupTNOMRcsj3meFgFn09HrO720u4tTVZ/ojA1Yq9X0LK9efb7KyLQ==
X-Received: by 2002:a05:6512:1598:b0:553:296b:a62 with SMTP id 2adb3069b0e04-553af92f3b5mr16886e87.12.1749750376611;
        Thu, 12 Jun 2025 10:46:16 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac11692fsm176902e87.24.2025.06.12.10.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 10:46:15 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 12 Jun 2025 19:46:12 +0200
To: Boqun Feng <boqun@fixme.name>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/3] rcu: Return early if callback is not specified
Message-ID: <aEsSZINUrRvy1g4F@pc636>
References: <20250610173450.107293-1-urezki@gmail.com>
 <4bc63cf3-29a4-4a64-be65-30f7bd55e31c@nvidia.com>
 <0caf7054-140e-4b6c-abd4-2ec2ebe79b2c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0caf7054-140e-4b6c-abd4-2ec2ebe79b2c@app.fastmail.com>

On Thu, Jun 12, 2025 at 10:30:38AM -0700, Boqun Feng wrote:
> 
> 
> On Tue, Jun 10, 2025, at 12:33 PM, Joel Fernandes wrote:
> > On 6/10/2025 1:34 PM, Uladzislau Rezki (Sony) wrote:
> >> Currently the call_rcu() API does not check whether a callback
> >> pointer is NULL. If NULL is passed, rcu_core() will try to invoke
> >> it, resulting in NULL pointer dereference and a kernel crash.
> >> 
> >> To prevent this and improve debuggability, this patch adds a check
> >> for NULL and emits a kernel stack trace to help identify a faulty
> >> caller.
> >> 
> >> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >
> > Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> >
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> 
Thank you for review, Boqun!

> > I will add this first one (only this one since we're discussing the others) to a
> > new rcu/fixes-for-6.16 branch, but let me know if any objections.
> >
> 
> Not sure it’s urgent enough given the current evidence.
> 
Let me clarify it a bit. My point is that, we get a kernel crash in a
subsystem we are responsible for, i.e. no matter if there are faulty
users of it(third party applications), the point is users can crash it.

The kernel robot reports it and it is already a strong indication that
the subsystem is not hardened against invalid inputs:

"BUG: unable to handle kernel NULL pointer dereference in rcu_core (3)"

so this in the rcu_core() which is part of RCU.

But, anyway Joel should decide. I shared my opinion :)

--
Uladzislau Rezki

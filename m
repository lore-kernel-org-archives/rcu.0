Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81823223704;
	Thu, 12 Jun 2025 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749720941; cv=none; b=ifLoanzfmAjeYSDe1zCJvH/NkEsUubMdGCHVx1MnoHYXZLPJ4eJaLHwsFTWsdNA+ZOrCq2L3vwy6EPj2mAu0L3Xj9irLo3HWnIGxxtVlOaZik+3bca9Zx++a4I8rkXYNFWX70DHau5bZ7PqsxdNxarazTSUxJarUjLkvZ3iQZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749720941; c=relaxed/simple;
	bh=z6JQ86YiJIgoBWZwHAMlfkxoeB4xDh9s9thGqfA6IGU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs9eXxokDHY709b1V/AkMNBIaQUyedrCqw5Pp5FYYiK3T7Zfqm1D1LJy87Ril/OFjBTAWdcYA4FLtHUi5p0OQ3iataLHsNNdJh6mh2JzZtkCuYFAd3w10ydYo9QQ43N85OvyNHnfV3G3DVk9ShMPt4k2XZdR/SJx1tEvfnAypM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTsefD8A; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTsefD8A"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5533c562608so657253e87.3;
        Thu, 12 Jun 2025 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749720936; x=1750325736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNGnfTj+6GYNJe3ZS7jJjl4kUJYeOo9otOuIH/BKLGI=;
        b=CTsefD8AumisvDUya3ZuRozrq4F5gKyCH026SsP1cU2MB9vdHW2T4uoS7m730tCs6Y
         qT4rcqNn7XjbD91O3EiPysz8iFDRhj+l5JmoV/NBSpaP6x4+WaU3wbA3f2nlV9OiJ59t
         Q+RZCN6AkosqKgx3vANl+rVG/8JNacOTWVPZao+xwpTwG2Q+FahV23ozUtg/OLN27DDF
         YD4XJM4NgRdaZeLwi6CQzy0+fM8Meut+beXS0JoTm6J1BA06OAhjq3YLuoy7nj4NlBQj
         nVfD7/nad/q6/RGVrG2YhdgR+CUQeLMnE/q6pRzLI3HqP5F8g5IFXmrcA+99wVgiI57A
         SnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749720936; x=1750325736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNGnfTj+6GYNJe3ZS7jJjl4kUJYeOo9otOuIH/BKLGI=;
        b=cGYV+i58oeiObeR1/cRt5LWxEA4c5wI+k0+XPYYtxwI4pol165gY44cD99eblulWQi
         2Q3h2V6/Zje8nHlFc9lQlg/iNAfDNUkdhQ22EIG+1RsBgR6BoAf5q1V2647J0VS02d1B
         473q8gJO16e1R3Os0M3FEP4Plx8w++N4r4d+zhxLnSUoByl8nsK1Jt0kUHfKeZRbr++c
         ZdRAfMw0WvFD3sXky534g25okd1P7HWZbwaSmWjnvtY1EgXF5rveeAPEAXAUiLus7AqH
         9imbbHD501krfUNx4werux0r7JoUO++0Vuiu25k97UWyuXRWK0FnrAqNKj3WAsBq6C4N
         JgqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Dki/BIR+Ix4/eq4qJJl92F93gDpvDKWi/LQKc21eQXWVw0D1Lzb2TkNbPNtRPndBHDR3@vger.kernel.org, AJvYcCVWqqzX7Rfw06a4RvhKjqy4mKaz36+l5oZjm1GEwCg/ppmoEPexNRVW9DvrRnW8eY3DZ/7VrRgbcbO7Pl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLCm68WsE/HZvapEGqBsq5gbLdSAtL0qoYN+Wbp3ZexYEIA4yn
	V+SOLAzrRLaOUP5bHaeWZOWmNtxdoPYnIkuM/DhaRjlUWPL1Ulk/sfWU
X-Gm-Gg: ASbGncseiw9IBi+YO0P61MLa3ZimHCOAj51Dy3KbGVjmerVzP/lmUp3kwr8la4Dr09i
	dkZ2bwZa8O/2nLhDVPi2XextM7dEhUNsuio4/TSCwa9RjhpHQcbA05F7YsL9R4IdPfJSyZjyiXU
	gyAQYNf1OfW7WGhWJfNfku0C76JLo0TrFh6dWCZnGkq8m9uRuG6elcC2BVJqXYtZZWUda8NPY2M
	YeB4nwt9I3EPnhkJyfkQj/wtDCHRFoL0KWPaTq5cvbYmXQKNcl+FDHzgsNb4vNfLjyqNLPOYdL7
	8EzGWEAOkFqx/xk35ko9+Jp1db1m3n/8+8xHtWCpDM4vGi6PF7W/j8CADkjWBRkVa076A4CvguY
	9jDyfHiwXYHs=
X-Google-Smtp-Source: AGHT+IFjmGroImrsdKJy+SHbFn730/jLMzQMi34SWtprg/tiQowSep8sCJk2Cq27McMGTl0+ZjOd7Q==
X-Received: by 2002:a05:6512:3ca1:b0:553:653f:1b21 with SMTP id 2adb3069b0e04-553a55f77admr710895e87.37.1749720936298;
        Thu, 12 Jun 2025 02:35:36 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1aaf71sm52194e87.106.2025.06.12.02.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 02:35:35 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 12 Jun 2025 11:35:32 +0200
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 2/2] Documentation/kernel-parameters: Update
 rcu_normal_wake_from_gp doc
Message-ID: <aEqfZMnp0tGtcEhX@pc636>
References: <20250611175658.91361-1-urezki@gmail.com>
 <20250611175658.91361-2-urezki@gmail.com>
 <fcac9488-a755-40a3-a643-b7cf7288714e@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcac9488-a755-40a3-a643-b7cf7288714e@nvidia.com>

On Wed, Jun 11, 2025 at 05:49:14PM -0400, Joel Fernandes wrote:
> 
> 
> On 6/11/2025 1:56 PM, Uladzislau Rezki (Sony) wrote:
> > Update the documentation about rcu_normal_wake_from_gp parameter.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
Thanks!

--
Uladzislau Rezki

Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92532380FE0
	for <rcu@vger.kernel.org>; Mon, 18 May 2026 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123942; cv=none; b=eacX6fc0pIbRRU035L9ySwTw9qTrZsLhpYCJHtyNwPWBDODSxyLjfaIAQEQPd/RqmNAQIsvz2g2+317Thk9Gqt0CdYwQu5yrdkGnwUuEZafEj3OAaccb2ptpksbTBNwrPb8/HLv3iWbK/A1JxqVTrQL+yx7nYLFIlrfI/uPPpWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123942; c=relaxed/simple;
	bh=m8SQUb8kqmTppEfGLOTBXcoJkkJkB2TKAa6me5v22FI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+i2H7IZ50CFMDoQxA0ewPu9fRu5baeILXMsSn1VubpigczcZvT0cRC3RLis5Y/6a613fvJykWSr0bHkA/aN9OedzNQ/G7A0RBfwSsNPh523ibuczBnEbLDZzuFoam5fz7mfRJP1huKTZYHsh3TMuaNKE71ewwbrvMjcc+hzNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7vIdy2G; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7vIdy2G"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa0862dda1so3501892e87.1
        for <rcu@vger.kernel.org>; Mon, 18 May 2026 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779123939; x=1779728739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1aYdPPySXDTosAZCONGXYPhhFbBEQuaYinrf43tyh/0=;
        b=Q7vIdy2Gy22B2evykOhZgkC51l9/aPYg3xY9UylNE5y9kkbNdx1I7apYoezw+zEO9Q
         qmRuUP5nvN1wGs5+M7tQTfU2y4E7dkymKoqVoNPZKcEPAfeGG80XF1nwDJn7C8ffP1dv
         2y+U0e9hptWEd1KuDfEkMlqMux6b+j11ENlmFCo6RqOKuKzoCNY9rinWi2dZB9DUVBpZ
         qmKdKxl6AltEcHQ2rUKtDEuhxhvRpA4mXP4L7pWYtshPShtH80GTNF65V/Zb7o9LIHYU
         Fg/3V34LVnwpNI4YG4hyLmVofWb6Z4rGIqMgv+c+bYNqlIKHYN7qAII51sJeuftHkACp
         lgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123939; x=1779728739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aYdPPySXDTosAZCONGXYPhhFbBEQuaYinrf43tyh/0=;
        b=ALjLiMhbaIg8rF3laL4rJjDqH1fMZQOhAM4rdiT3oXH+gAZE9dpxbHFBd81GLtmEde
         e+O6eToZeO4dXgzkm1MOltw+p6TgWyY874VZNNG6/zl6DeqIFwU1MCvZZtwCHYWiGN5I
         36UHychkZmqhm5K8zHLc6/EYXQ07VvDFFzxr/HwiI79LshW6jV/MX0CJY4kWoCDrPbKB
         O8VU8jQ2LIlcOLPurBqJ9+X6wBFRnev35ww9A2fhadIiBJxgGSY9Fq4PUUMKQcImcQgd
         LlEY+Euh1tesE4na0jC/ZfVCE5iPQ7FtoszkzTa6Vi/IEmyF+/Kio4IyNU5yUhzozhnm
         7aXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pTYS3jtZSlYnDCdG+eEwVQw9O17xUDhXiH6eoTJ9NQ+s25Rrn/lynT2DyX5asjCOX2aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPpxeFCjSWSt4MONGa5mttRK9sygjLGmfZ4ru4V/zVvs17ZLEC
	2KDHfz+TOhESw1mcyqPSvBxuNxmi7D3As6VVSb4sIF7B+xQyvnSju3VW
X-Gm-Gg: Acq92OFocafE1wwUMz1zCKKmEBeX1HOdUwWTQDIz3/VxGe6EA/kQ6vqu4as9YymrfAo
	Nso/Xlrhfb71cL3RZ+NC7VJXnG+C4feg2WlTCavc6LTKICUsKVFAisd/4lLrtEJyVl4fRdO63Iz
	+6Kgk3wXLWzg+PRQ3CLdf5cBrSQdzdl3RQVhg+8vV3t47OoxpMgM5ctW8BQVuzlIDZB5dm81l9z
	RecJI0E1sTZ/8X/cLro8hVnlK9gyE5OQ0vhOf+IA/gQXW0aGgkrQ1RUhhbCK3xNe6Bc9JkuHtxW
	6UAyVanF70FanSbcWyph9Z0zQAY688y97tZmoJtMCohhKKV0tUJt/uzXvquQ341ONLS0upqOAe2
	QdcY5VTKtpIkYxTUN/5eRETa8CJCAWVksnoi9uXP9dg0q20Skh7TOGyYAft/aavojSnSpX8jhXb
	c=
X-Received: by 2002:a05:6512:3406:b0:5a8:e61c:371c with SMTP id 2adb3069b0e04-5aa0e7638afmr5741206e87.26.1779123938228;
        Mon, 18 May 2026 10:05:38 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164c5712sm3391074e87.59.2026.05.18.10.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:05:37 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 18 May 2026 19:05:36 +0200
To: Boqun Feng <boqun@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, paulmck@kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Samir <samir@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH -next v1 05/12] srcu: Don't queue workqueue handlers to
 never-online CPUs
Message-ID: <agtG4JmmyH1ycg16@milan>
References: <20260511175448.153326-1-urezki@gmail.com>
 <20260511175448.153326-6-urezki@gmail.com>
 <f669fbc9-c068-489f-bd91-4e81561a6e58@leemhuis.info>
 <agm4-6f-6rOgQPFB@pc636>
 <3dd5cce0-51f9-4cf1-81b8-246e6c6a633a@paulmck-laptop>
 <53d546e4-8db0-4e14-a79d-270212081be7@leemhuis.info>
 <ags6ug97zNR6Fiiw@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ags6ug97zNR6Fiiw@tardis.local>

On Mon, May 18, 2026 at 09:13:46AM -0700, Boqun Feng wrote:
> On Sun, May 17, 2026 at 09:11:10PM +0200, Thorsten Leemhuis wrote:
> > On 5/17/26 20:03, Paul E. McKenney wrote:
> > > On Sun, May 17, 2026 at 02:47:55PM +0200, Uladzislau Rezki wrote:
> > >> On Wed, May 13, 2026 at 12:38:01PM +0200, Thorsten Leemhuis wrote:
> > >>> On 5/11/26 19:54, Uladzislau Rezki (Sony) wrote:
> > >>>> From: "Paul E. McKenney" <paulmck@kernel.org>
> > >>>>
> > >>>> While an srcu_struct structure is in the midst of switching from CPU-0
> > >>>> to all-CPUs state, it can attempt to invoke callbacks for CPUs that
> > >>>> have never been online.  Worse yet, it can attempt in invoke callbacks
> > >>>> for CPUs that never will be online, even including imaginary CPUs not in
> > >>>> cpu_possible_mask.  This can cause hangs on s390,
> > >>>
> > >>> Uladzislau, Paul, according to the fixes tag below this change fixes a
> > >>> change that went into 7.0-rc6 -- and apparently causes a "hang" on some
> > >>> architectures. So shouldn't this be heading to mainline instead of
> > >>> -next? Ideally with a stable tag to ensure backporting to 7.0.y, but
> > >>> that is a separate decision?
> > >>>
> 
> FWIW, I'm happy to create an urgent PR to Linus with this fix. Since it
> fixes a commit in the previous urgent fix PR from me. Ulad, let me know
> if you want me to do it.
> 
I do not mind :) So i can drop this patch!

--
Uladzislau Rezki

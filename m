Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43455346E54
	for <rcu@vger.kernel.org>; Tue, 13 Jan 2026 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327130; cv=none; b=e7X8fj9gpR3ZMPN0iUAxdtO/i9brFvxbNfNqmwv1d2QCevpHCVf+59K+vENnHM0JN+HwQMTABb3fZe2sxTZFqp8BousY01mcx3LTf+42XZmPZsaOjM41OFAobvKwzs7OkH8KK14D5t3PGtwqEcSLaHfefqkRRxOSpD8R5TGjKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327130; c=relaxed/simple;
	bh=SfPB3/xLf0+Q0sgIK1rIaZu9INn0FIT+GeEV0IL3yNY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4/tXk2TtAajW/NlPgHELiDxS2m5KShY7hkCFSr3c7218Z0GyMoBXkDFklPikFs6BUsoj4S3aoJjlc4sbxUyfezIo5gY8viqd+PhN5ZfTJQCLqe25Vg0XXMV8AM8QHJz6FEaRRHhHzm9+eBRmlRVCSHUYLBjxuC13KfJBpR11Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SK4vJ8ob; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK4vJ8ob"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b9fee282dso218446e87.3
        for <rcu@vger.kernel.org>; Tue, 13 Jan 2026 09:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768327127; x=1768931927; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M8BgzU01XtACBvJTKvVspgO8XlmqsytHJp8hNt7BvL8=;
        b=SK4vJ8obY9g8YiocB7C4oOyRnd+IJP1q4p34roX7dtnXrBsoklYn2Tp9IKAnbGZVss
         ift4a9HKgX2l3TvQV+E/RP9JSyXwFkWAnRKjAQ0yVm7IOvFbCjPsyeUaJsExNJ0V7UcV
         ZTmn1RC0IuIfv2PG/zTwJTGhD2zMYDQR+x6+Tj9ROt15MD6oX9qSQiAY9ZKxtmjgHgDr
         xU3qHNMdD/krqDjGsR2/QthQ2ol+a4YwJUGJP/xKCFt6A5bBqMSuP8JMuNriqv2HLcCs
         E17Knd4sKcRJQ69Pjg5JrQEJ3LrgM3JsRD7CiyCgSg2xqNYuNGThK87I6CjjTMD/KnO8
         0EJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768327127; x=1768931927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8BgzU01XtACBvJTKvVspgO8XlmqsytHJp8hNt7BvL8=;
        b=vrJVakiEU7Xcj47KPxlXf/rmAq92i3wIKFTIWG2uSv5cbrRkzbK/63pu03QfziHxi4
         bFtDwPykVXBrcLfgaiXUuM281u6NeuqqEJbAcap58eI74m559T821qz1seZhgSnzk6fu
         pS4Po7Sky1GJ8PsNA3I+K3Md0BchvnTsDc8igCFwbgyhaMBoS92ThU0CNjR6eaNcForg
         vNJ8Z+94Ll8Dr4TCLBXQJ+0uzPdhZgtxujqTbRZisCqQ03y5+c+5E6V9iI5cAm9IuRSO
         b/1hBwNmeJnF5g0SojpQGIXiwzQUHkYhKE161lLzjGhK9Gys5w62VI+rH82F2digV/PH
         ZLmA==
X-Forwarded-Encrypted: i=1; AJvYcCUFr+VPh/SE8FAmD0s2YF8uW6MWmx39S9Gp5mIzT3pzoErk43NBynjya2++AJ58LhTszqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyskgZgrjHbQtTa1CGYeHV1DkPg/foFUUF/QIyhCyl8UDllqFAg
	ldHK6THGjwTeGo0qb6PHmIJ4btrKLRJCtb8FeF3Upnw/9N062/DQyFUQ
X-Gm-Gg: AY/fxX5cRIWxfZj86AWlVri6wskvPq/O7OYC7rmQlpZIYZaFgYZtvLebvhQ6RV9YLiC
	d98IFdiYMIiK+ABES5ChKMuzhMbotu8im5ZAYkNN6BP603MFnVM6fe/wrb4eoMRXRu2wTQmx8Qg
	WWxUG78WzcHvlsMNRWaPaQa/qoDJB7lVThaVxLIY4XQ3H93rh8sDeOrOj65jgAXAQRkJ8lDFZKS
	Bu/DmzS+My7ZebjBjnV2y4qYBmwFy3qLD3JL1AN3q3UqhmP+v21VUhjk/cJxY4dar/nr3stv6h8
	uOmS87xF+cU4chn8Pthin+9tODCAo+97cDLwMjLE0dMgKLBjJrMbuOKfutlHYVGMgDpfcBxxEXz
	ove1tRuRUlMWsxbfYOu7q6Qvf3d+V6+42dAReHZExoI4nXiZaOTKrmpoBaoTZsqI=
X-Google-Smtp-Source: AGHT+IG7EM3OYRW75EDEohbswFl7XGuAv2nqrJpiyoCT2CD01QnRPvHtvnnWGlwCM1AIRpdqGPHRIA==
X-Received: by 2002:a2e:b8c9:0:b0:383:5482:b858 with SMTP id 38308e7fff4ca-3835482cc71mr9110701fa.34.1768327127086;
        Tue, 13 Jan 2026 09:58:47 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb3a053esm47554141fa.5.2026.01.13.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:58:46 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 13 Jan 2026 18:58:44 +0100
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	"frederic@kernel.org" <frederic@kernel.org>,
	"neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"srikar@linux.ibm.com" <srikar@linux.ibm.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <aWaH1AdJeSVVB5UZ@milan>
References: <aWTIDGQ1_NYeO4iU@pc636>
 <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <aWUqtX2PGDOZUaDW@milan>
 <D5086AE0-7158-49C4-8511-47F99021B2AE@nvidia.com>
 <aWY4LQZrudJ4SB8G@pc636>
 <B077EC99-57EC-48B8-9B71-237A7A95DFE2@nvidia.com>
 <aWZUAhbMV_BHamr_@milan>
 <6d05f9ea-fc4f-4115-a416-8e779f17e0fb@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d05f9ea-fc4f-4115-a416-8e779f17e0fb@nvidia.com>

On Tue, Jan 13, 2026 at 09:32:13AM -0500, Joel Fernandes wrote:
> 
> 
> On 1/13/2026 9:17 AM, Uladzislau Rezki wrote:
> > On Tue, Jan 13, 2026 at 12:44:10PM +0000, Joel Fernandes wrote:
> >>
> >>
> >>> On Jan 13, 2026, at 7:19 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> >>>
> >>> ﻿On Mon, Jan 12, 2026 at 05:36:24PM +0000, Joel Fernandes wrote:
> >>>>
> >>>>
> >>>>>> On Jan 12, 2026, at 12:09 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> >>>>>
> >>>>> ﻿On Mon, Jan 12, 2026 at 04:09:49PM +0000, Joel Fernandes wrote:
> >>>>>>
> >>>>>>
> >>>>>>>> On Jan 12, 2026, at 7:57 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> >>>>>>>
> >>>>>>> ﻿Hello, Shrikanth!
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> On 1/12/26 3:38 PM, Uladzislau Rezki wrote:
> >>>>>>>>> On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> >>>>>>>>>> Bulk CPU hotplug operations—such as switching SMT modes across all
> >>>>>>>>>> cores—require hotplugging multiple CPUs in rapid succession. On large
> >>>>>>>>>> systems, this process takes significant time, increasing as the number
> >>>>>>>>>> of CPUs grows, leading to substantial delays on high-core-count
> >>>>>>>>>> machines. Analysis [1] reveals that the majority of this time is spent
> >>>>>>>>>> waiting for synchronize_rcu().
> >>>>>>>>>>
> >>>>>>>>>> Expedite synchronize_rcu() during the hotplug path to accelerate the
> >>>>>>>>>> operation. Since CPU hotplug is a user-initiated administrative task,
> >>>>>>>>>> it should complete as quickly as possible.
> >>>>>>>>>>
> >>>>>>>>>> Performance data on a PPC64 system with 400 CPUs:
> >>>>>>>>>>
> >>>>>>>>>> + ppc64_cpu --smt=1 (SMT8 to SMT1)
> >>>>>>>>>> Before: real 1m14.792s
> >>>>>>>>>> After:  real 0m03.205s  # ~23x improvement
> >>>>>>>>>>
> >>>>>>>>>> + ppc64_cpu --smt=8 (SMT1 to SMT8)
> >>>>>>>>>> Before: real 2m27.695s
> >>>>>>>>>> After:  real 0m02.510s  # ~58x improvement
> >>>>>>>>>>
> >>>>>>>>>> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
> >>>>>>>>>>
> >>>>>>>>>> [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
> >>>>>>>>>>
> >>>>>>>>> Also you can try: echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> >>>>>>>>> to speedup regular synchronize_rcu() call. But i am not saying that it would beat
> >>>>>>>>> your "expedited switch" improvement.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Hi Uladzislau.
> >>>>>>>>
> >>>>>>>> Had a discussion on this at LPC, having in kernel solution is likely
> >>>>>>>> better than having it in userspace.
> >>>>>>>>
> >>>>>>>> - Having it in kernel would make it work across all archs. Why should
> >>>>>>>> any user wait when one initiates the hotplug.
> >>>>>>>>
> >>>>>>>> - userspace tools are spread across such as chcpu, ppc64_cpu etc.
> >>>>>>>> though internally most do "0/1 > /sys/devices/system/cpu/cpuN/online".
> >>>>>>>> We will have to repeat the same in each tool.
> >>>>>>>>
> >>>>>>>> - There is already /sys/kernel/rcu_expedited which is better if at all
> >>>>>>>> we need to fallback to userspace.
> >>>>>>>>
> >>>>>>> Sounds good to me. I agree it is better to bypass parameters.
> >>>>>>
> >>>>>> Another way to make it in-kernel would be to make the RCU normal wake from GP optimization enabled for > 16 CPUs by default.
> >>>>>>
> >>>>>> I was considering this, but I did not bring it up because I did not know that there are large systems that might benefit from it until now.
> >>>>>>
> >>>>> IMO, we can increase that threshold. 512/1024 is not a problem at all.
> >>>>> But as Paul mentioned, we should consider scalability enhancement. From
> >>>>> the other hand it is also probably worth to get into the state when we
> >>>>> really see them :)
> >>>>
> >>>> Instead of pegging to number of CPUs, perhaps the optimization should be dynamic? That is, default to it unless synchronize_rcu load is high, default to the sr_normal wake-up optimization. Of course carefully considering all corner cases, adequate testing and all that ;-)
> >>>>
> >>> Honestly i do not see use cases when we are not up to speed to process
> >>> all callbacks in time keeping in mind that it is blocking context call.
> >>>
> >>> How many of them should be in flight(blocked contexts) to make it starve... :)
> >>> According to my last evaluation it was ~64K.
> >>>
> >>> Note i do not say that it should not be scaled.
> >>
> >> But you did not test that on large system with 1000s of CPUs right? 
> >>
> > No, no. I do not have access to such systems.
> > 
> >>
> >> So the options I see are: either default to always using the optimization,
> >> not just for less than 17 CPUs (what you are saying above). Or, do what I said
> >> above (safer for system with 1000s of CPUs and less risky).
> >>
> > You mean introduce threshold and count how many nodes are in queue?
> 
> Yes.
> 
> > To me it sounds not optimal and looks like a temporary solution. 
> 
> Not more sub-optimal than the existing 16 CPU hard-coded solution I suppose.
> 
It was trial testing :) Agree we should do something with it.

> > 
> > Long term wise, it is better to split it, i mean to scale.
> 
> But the scalable solution is already there: the !synchronize_rcu_normal path,
> right? And splitting the list won't help this use case anyway.
> 
Fair point.

> > 
> > Do you know who can test it on ~1000 CPUs system? So we have some figures.
> 
> I don't have such systems either. The most I can go is ~200+ CPUs. Perhaps the
> folks on this thread have such systems as they mentioned 1900+ CPU systems. They
> should be happy to test.
> 
> > 
> > What i have is 256 CPUs system i can test on.
> Same boat. ;-)
> 
:)

--
Uladzislau Rezki

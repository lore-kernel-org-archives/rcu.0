Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988B36197F
	for <rcu@vger.kernel.org>; Wed,  7 Oct 2026 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791341808; cv=none; b=c+T1eyCn9aleX1DpjeSOoZAPHrkj96cWHk9XpSq1hu25HegkyfDVbqMPuZHyO+JnLWEEv1f+gUalWZ+BnnCHT3DrsDAND+/LP+Dt92I3A8OF6PbkZhp1HF5nbxKaK7ssCEGLSZPAl3H9o26OvzhTpGB1l/khF66H/cD5kYV2iZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791341808; c=relaxed/simple;
	bh=aTGbHorcC7spW+tVRUG766lW2N40Ap2NyU66RpBUSzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=DLLlkB/tVLzPRWjxCyrZhKoYtk1Ot/Y+xcYtWoqsGWl2PWXmw6yVgXLpVU5R0Tdzz17//G2WRhzGvFRFzhPWT8BTjrlXqwJsevuH2g/U+S7MAkxiLtwkKtgQU4DvwalkOHOd98CRGIckApZY5qJrbUiicr061ykvFbEHpmCw7Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o065dOHQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o065dOHQ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e6038cebefso2887025ad.0
        for <rcu@vger.kernel.org>; Tue, 06 Oct 2026 19:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791341806; x=1791946606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:mail-followup-to:references:in-reply-to:message-id
         :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JfwUS945YBdly7tT5sHJsRnusEwHVI6ntMLloizipfE=;
        b=o065dOHQ1whVJXQK9NV6DfVVYRTUi6B1XsP8/B2y1+R7MSwboHHvcSE+WreQ3YN/So
         mP2F36RWrp1JJdJQ0kNGtf70xTGqimrVA/SsBOgTMVo+PeHTlMhgZT82+8lGGO9zyK6D
         n03t4rh/VWxXV/9zrPNfQ33QSbndRV910TWSaXiRKTN3eLoB99Whtp4Mj3MU13GjG8nK
         Ab0hHLr3g0MpQRYkfBRnWa1FSAt9+kWeTfXRvoG65wDh6bu1Hxcy84e+3+5a5XIybZfj
         MSNsUeV5V6ErvytYWvR7lNFe4f+6LmRmqmEBdhpF5CKrkKc/F2Yrq7wh4nC0+/Zi+Os4
         Zq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791341806; x=1791946606;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:mail-followup-to:references:in-reply-to:message-id
         :date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JfwUS945YBdly7tT5sHJsRnusEwHVI6ntMLloizipfE=;
        b=gk4JVpbtLV0FO+DgvcsRXP6SCXnVciSVN0qZH1f59mISgOkoYJG9uuRh69Kn6WtJ9m
         OftnemkzsRNPphfo/0/suoJ/eOSagF59i3nK7CnNWxfwWHFHmKb5SlxIzOJrUNXAXLiv
         bQ+XPuWu3o7kl/YIqGzgXxaVL6rG/dNPes6Lcf1atoaNynuuV/Iu47HisSFMMl0rq2k/
         dV1MVuSQq6yanDWuiHOPkcxcGw41z48jnZ2hxjuKNkng3QIFJuzvWoZ47/CjOBBBPxam
         XRI2osmt3HNZQWcQ4xUUt0ZvGN9T+8vyz02o12o0JBFCNaHMHV8Bz41W6zuhQRlqFc+8
         Hf/w==
X-Forwarded-Encrypted: i=1; AKwUvBzCDgKOqQ6SY6imBmXtegROGWpW9NWgleOoR4TA0jwxejcd7njhGW+XtWWdHET/NDtxsOw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1ZUa2AqQscSCogt6flMEgXKQc5A8f2AHCXg5VZrcnX9qAEhD/
	bWDcoMGsnjKWZBk+lS8wMc7qhw47lj1H/ypqwU5IqRdUFYoWezwd35/J1X+uwVlY
X-Gm-Gg: AYBFou17iig5i9aVzEGQNFM4TKUeZwmqC+T/6Nxl6IllP7LMktJCgPIukIysFt/8Itt
	Sg75fIp/5OrPCk65pb1ail0m/VDE4/V8j7mahfP83CQV5Oy08TASclMtVl488wnmw44nt3OLevU
	POM6ag5aZU1+mkbPgHNHYsWoKxH8vcJqFjHXpwzIhJ49nyE34YUi9SnyJXoeAKqqez9vt3AArgS
	cG6U1HQuUN3GLL9VuAt1P7StI2vBeQBPn5hB7RWHY4kTSYrjYOtZH69X9TYLVyPhWBfzQ27h69k
	pjic/3aXxT1F8LrmwturWo7TuX+nimlsvzA/Jsqqkv+5kky+GFaH4UHcBn3OsiDTpCuGA+7xXq2
	CT17nT7RcxjJoDKKFVIR6+NVoRGqgJjV4awND0JcbYrRKJJ5pTBdJLGmDB0WhcTnQfcn2LlFJtU
	OLXI1xQ9ZXZHFl55H1RCAn2QLH70YrVBv2o89V0cFpSHHFMRwrM1XRL+XJKWxnyLMBwpQb/XNYq
	S+HA5ucUQ==
X-Received: by 2002:a17:902:7206:b0:2dd:ad74:ac7e with SMTP id d9443c01a7336-2e6003c3090mr7227615ad.25.1791341806478;
        Tue, 06 Oct 2026 19:56:46 -0700 (PDT)
Received: from localhost.localdomain ([8.139.245.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60f6626afsm812225ad.44.2026.10.06.19.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 19:56:46 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH] rcu: Enable runtime reset of the RCU stall panic count
Date: Wed,  7 Oct 2026 10:56:39 +0800
Message-ID: <asW059of9u0ohxQI@63b45mr6s164qmn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <53383f19-3d54-405b-85af-f597b69befe6@nvidia.com>
References: <20261004-rcu-v1-1-3799a44367f1@gmail.com> <00F6D386-FE41-42E3-9B89-07381A49E061@nvidia.com> <asThhHxoFP2L25Nc@63b45mr6s164qmn> <A522703D-CBCE-4F3A-9CA2-968BA382166C@nvidia.com> <asT08QHOiIJrfIIZ@63b45mr6s164qmn> <53383f19-3d54-405b-85af-f597b69befe6@nvidia.com>
Mail-Followup-To: Cunlong Li <shenxiaogll@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 06, 2026 at 05:27:51PM -0400, Joel Fernandes wrote:
> 
> 
> On 10/6/2026 9:17 AM, Cunlong Li wrote:
> >> It sounds like you do know that it is likely transient - but based on this description and the below, it sounds like you have not yet found a use of this patch.
> >>
> >>
> > To be precise, we worry that some of the stalls were transient, so a
> > panic reboot would affect the users.  But we have no hard evidence
> > either way: every incident ended in a forced reset, and the dmesg was
> > lost.  Going forward, we plan to enable the NMI and kdump to keep
> > investigating the cause of the RCU stalls. We will also monitor dmesg
> > to confirm whether transient RCU stalls actually occur.
> 
> 
> Right, I just worry that if you're not seeing recoverable/transient stalls and
> you start using this patch, then you might be causing side-effects that don't
> really help your problem and might be masking the real issue. It would be good
> to debug this further, and fix the right way IMO.
> 
> If you show that this patch indeed helps your problem, we can consider it for
> 7.5, but there's little bit of time. :-)

Hi Joel,

Understood, thanks.  We will keep monitoring dmesg for the root cause.
Once we observe self-recovering RCU stalls, we will resubmit the patch
with the evidence.

Thanks,
Cunlong

> 
> Thanks,
> 
> Joel Fernandes
> 
> 

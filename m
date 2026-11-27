Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792217;
	b=mLLtCuBDjUb9yp5LNIey6uYZKoMNjBSQfEvINl76h6enmLeZjWeNTvmv6uBP7bbbbM7L
	 dS7e+bZd0eUJU+yCQtlvko0J2tlxo6p6cmZ7M2sGYRiBsXnRBSPfC2D9C0XV71hU/eIAO
	 2X7Zxz+HMwUaC309fn6ydFim/5UU9n930IYch8OCKK6CpcnPWBaP65VIU5UUZ0rHPtzU7
	 V1/6u53GwK6OkA8ypAr4Kdyq6gVI0oYSndSqkFm3xiULUazizgQsuc7kunkxjfYquINVj
	 8ctABql/EKzzKgLR2UeNPkJubnrKVR1Zzd/vz8+mouFjAfWUUoryL+ts0AhutfGk2/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=dB3Mu1p4rL6bAO330MA2e6OIkjqTQSd8YGpfYYCrr/0=;
	b=jDDd0pi7trAwT/Bj/RSbLpHqAb8ZwaBxWhNXfhwme6JJuQyPqSRDTAg++NHkMpgVjxnl
	 fDuvkL3gZJXN4ViwWHVCBZRRbstllA/0v7do5/w2h5uK/73XXrQvgxIn+r/jPkzDoWNRB
	 4iEBcrKkZaiIkAuLcHun2e2vCHUEXoIAllMzX00oOCsWJlY+okaxh9HnIAoMcXH4HQGLW
	 HoO8ADvqN05PlE4+eQ2AQMItUY6pYPC2spFdg3qCgZyAdcjYCX4qK0A/DBeTZRLQH17pB
	 lPjWWkTTCOrmJ0EZ8Z/GIRKsRhilmLxNCSFAl0qXO0xLCE4Sr4YCkcSfoovAvDBqILg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=BNBBToX9;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F7B606A31E
	for <rcu@vger.kernel.org>; Fri, 27 Nov 2026 15:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F7B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=BNBBToX9
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b467581b98so79228235e9.0
        for <rcu@vger.kernel.org>; Fri, 27 Nov 2026 07:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795792216; x=1796397016; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dB3Mu1p4rL6bAO330MA2e6OIkjqTQSd8YGpfYYCrr/0=;
        b=BNBBToX9KBOtwdKh9WaJ9mUZLDZorMOpz24pc+Ie7Va4OwK4iffPBdEtrf+IAhTs/r
         RMHWVFmj7aQYIJ4PL4JujOOWTdVODgr3hmIix7XIX8JeVbRP8EyrmzdxI9ihdcxVxRmX
         YJfXkCyYI+9ioSrCpKMUdEmGe1cNXx7B/3yf8+hpb9hH+B2tDqqO1HOuN4Nq3MjPgofw
         kCk7u/CuHzkgPPsl9yq4Q3NK8qwZvU9/2bc8ysn81X3mCDGpLJEkF8Knzevfj+fJrv2B
         CE/0YYW8j4fdZcHmkpjewsVgd59W92doOnUF0T1AhDGFc7qqPcYEPy/B/pdc3vGo7DYi
         1ooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795792216; x=1796397016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dB3Mu1p4rL6bAO330MA2e6OIkjqTQSd8YGpfYYCrr/0=;
        b=ri8iqiIU/R5xgbd78lISH5nVmqDRMJJwqueuDE0ZrhTUQmdfDoVotoen2u3kkzXj1A
         YXLJRlO2bFRxUQbScz4jQsW5muKEYdnCaXVvEEtLnYUxHOgtihTTUcqSaYdUyO07eeNN
         OuQOtl5qFHrOXfFS9zS4xaTlWO9eFeMhn9j13n8Rsey6/3nQmkPVN728LcIzbPRe8Gg7
         Uoll2I9mvRbCLhfRRgxXKipbOAqetCJz52Zx3LjbJydXLZib+CPjxrDxjmVhHUKVjAiP
         PctyCvE8zIzZ0qcgsp08eWnWvQFEuG+vkSDJRmZkqh87dnND03dAgmCDxARf49nkP8hz
         7NFg==
X-Forwarded-Encrypted: i=1; AL+hErFv+/gLuvOIjnJrY/IMdYh4GK6u3Mwe6ZJl0kAkFwpsSDJDykEjfWqeBHN339xPYNyAtTM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Lkz1lCK0a/xfbc6keNkZBRdIGgWyHX+/WP6f9Nx5k2q6/+obm
	BOE9qF1Uei3iDecX2rS0m2kiJRALFLZbwmGzCWvw9OQIgzCX2nwlBdwc6U8PFOA9Zb4=
X-Gm-Gg: AZFdTZfGIrLUmIdOqTlyFHgQn0htMvQkjFlt+jNx5CMhasQshVVcpqCHoLX3pVZJ4Hs
	wVzHD1QpbuREg+YDZsULoRhAC2WVXuGbOZRwVJfikRIVpTTinlZVwUshOJuDgsnjjFp0FkmsuEl
	SZMAdtkD6NRbKAFMq5zbIE6e6KPRDBA7lyBuwR5z/y7GcpssXxfn9KyZ8/DpBODQdfjmWcj/rzJ
	q+Kwc262fOU0FHXoaB4cA2ktMW+Y9H0RmTptXOh5iswqTNPFN9KO4xaNxPxIr+rl/I4/QuXs4QD
	/bpBIegMswOanYlfhx2Zl+UJth13FXKxkH6M0/J9plCuQkK3rpnUBwV9K2H7NiQ0YPUS2C5Bp3f
	Vg6VSXrUj+IBHqYv/B+f64n+z6VxEU5me2w2z1xNdAoz+1HqXGuIoGb50tVQkjwrFu1JhFg0RcT
	/jZmNyvIt4MPqg53v64yOEmjbfDACPwxRi8LK0bEyUzXKSCVNWcq8Ikqhvrq06Mcq8Qw+S8CazH
	RwwAEsFAPxgfIRhaXTVSfEFxNXXhjAfrngPTQnj71TQ6KBsqTyJQqiP5G2OSbjE4z7qXMZALPvG
	O4Yj5MxTKsoPK8ZxUDlevD0nAVr9meXynqcrOV07c8w7XXwR3hAr
X-Received: by 2002:a05:600c:468c:b0:4bb:6d61:af7c with SMTP id 5b1f17b1804b1-4bb88944bf5mr493578005e9.35.1795792215604;
        Fri, 27 Nov 2026 07:10:15 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm729529545e9.8.2026.11.27.07.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 07:10:15 -0800 (PST)
Date: Fri, 27 Nov 2026 16:10:12 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: "Ravindran, Binoy" <binoy@vt.edu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
	"Shastri, Jaidev" <jaidevshastri@vt.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] livepatch: Include exiting tasks in the transition
Message-ID: <awmdVLfnwgrS9VfS@pathway.suse.cz>
References: <20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu>
 <20261125-klp-series-v3-v3-2-b1e0f79af331@vt.edu>
 <sashiko-outbox-234405@kernel.org>
 <DM6PR05MB4137C0B5BB4D88A9D5847EBAD1432@DM6PR05MB4137.namprd05.prod.outlook.com>
 <CALOAHbAQuYG__4b054bRobVRyT+v143wBcVAN26T_PtiO-oqmA@mail.gmail.com>
 <awmWExtIJGM805__@pathway.suse.cz>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awmWExtIJGM805__@pathway.suse.cz>

On Fri 2026-11-27 15:39:15, Petr Mladek wrote:
> On Thu 2026-11-26 11:12:27, Yafang Shao wrote:
> > On Thu, Nov 26, 2026 at 8:58 AM Ravindran, Binoy <binoy@vt.edu> wrote:
> > >
> > >
> > > Thanks, this is right. A dying task reports its quiescent state in
> > > rcu_note_context_switch(), early in __schedule(), and then still runs
> > > traceable code, such as update_rq_clock() and pick_next_task(), until
> > > switch_to(). RCU does not promise to wait for code after that point, and
> > > with expedited grace periods the quiescent state is reported right
> > > there, so synchronize_rcu() can return too early.
> > > klp_synchronize_transition(), which v2 used, does not have this
> > > problem: schedule_on_each_cpu() completes only after the work item has
> > > run on every CPU, which on the dying task's CPU happens only after
> > > switch_to().
> > >
> > > v4 goes back to klp_synchronize_transition() for both waits and keeps
> > > klp_try_switch_exiting_tasks() from v3. I will send it after rerunning
> > > the tests.
> > >
> > > Yafang, this reverses your second suggestion; I hope the reason above
> > > makes sense. It also brings back the v2 transition times.
> > 
> > Agreed. I missed the point that the quiescent state is reported early
> > in __schedule(), and that the code from there until switch_to() is not
> > covered by synchronize_rcu(). Thanks for pointing that out.
> 
> Honestly, I think that synchronize_srcu() should work. Otherwise,
> the comment in rcu_tasks_postgp() would be wrong.
> 
> IMHO, the trick is that there are two interlacing rcu_read() periods
> in do_exit() and synchronize_rcu(), see the comment in
> rcu_tasks_postscan() and the commit e4e1e8089c5fd9 ("rcu-tasks:
> Improve comments explaining tasks_rcu_exit_srcu purpose").

Wait! I might be wrong. I think that it does not work because
the 1st rcu_read section ends in exit_rcu() which is called
before exit_tasks_rcu_finish() where the task is removed
from rcu_tasks_exit_list.

By other words, the task is removed from the rcu_tasks_exit_list
in the later 2nd RCU period. So, if synchronize_rcu() is going
to wait for this 2nd period then it might end prematurely because
the quiescent state is reported by rcu_note_context_switch()
early in __schedule().

But I might miss something. I am not sure which period
synchronize_rcu() is waiting for.

Best Regards,
Petr

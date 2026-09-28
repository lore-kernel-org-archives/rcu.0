Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A661C1D5ADE
	for <rcu@vger.kernel.org>; Mon, 28 Sep 2026 02:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790564068; cv=pass; b=Wdg8IJyh8g0B3fYjelfO7x3X98qWjLpZs9TcsEdu6vcEaaRPivqjhIqTErCFf8cAEnURVuS+x/lNDThhTmUMPuFfKfzUFhDBfzv4Qc+aOBjnKI/fuWIeMfn1wWqEFlZSGmStwVohdUKEC/R3RzH2v7f1RzPZ/nbbNXDMI3SnjcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790564068; c=relaxed/simple;
	bh=b5TXDuYo7Sg6BEFdqqSCFhdBoDD1ttufzjg1FLnBJmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQkGWVdHknzuZ32j3fvae6Pl6Ct4lO0Z1FhKxzQ4qse9Hp8eGPMDeG39AdF2dfkrIRsCYhsc+CXiTR8jNS3qd2mH0PPzR+R2uCseyJ9YLcWysNchSIRjbS7qb5dAeX3C1u52OfimyDUTp1Mt2MyyaPE9KxXnbHOkG7HL7ElRtHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UragofS5; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UragofS5"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d8239so20422235e9.0
        for <rcu@vger.kernel.org>; Sun, 27 Sep 2026 19:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790564065; cv=none;
        d=google.com; s=arc-20260327;
        b=GZZ7r8WePwGBhFf2SscWjj9g11V0Dh+FM5Df1HCv3YDCuVR24rw5R0qKrmE5A65oVp
         WUG3ofG2d7LWNetq9EnBIy7KSAPZEke4qaIHFG9DQJSF2QXZSScSn0NkQavpKhqcK95A
         KSme6kKLQiB6mfKYyWyKj3YX8PPWX3C+Vr7nESa0f+IPBhKi8Eipv5w2ate2bh7MK+aj
         CeIbPadAF+GNmwFOu2rVhDOCgqK3FHlSqIOxW0/oVTAl/+JmYBWydC2/jQfPPfW3N5/X
         YQ0DhL+5sFr8BOYF9xRcq5NMUlPqt6ibuJMBHfz0hm4xbYeKHRmwlTnMKYEHOOYhG9s1
         5oGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nxSV4vyNJBxBq3nFqrv4BdTyhQ8t7NPAkYwT/z/Lexg=;
        fh=ZbpARb0bK+lqAeKB4Ul3kb1VwfBBE7eKHKxSuzg8/QU=;
        b=ElTcA3JJe6nBx7Pa0pZNvJdTb4QaLUwDG2W1AyMkWD5B5v89B3BSqwygRI9nwDeRoT
         ZraWYAcfjxSLsVG+vtLw+2vLmub1V1xi4T7luSnJe2wAsMQs5LHNhCpFfmxK30RCy6OD
         Ki5OYAjrQhlYMY6+ChknO1caKGpr60ovr7AhqEfGH7AEouKgzmcTkRVcKTInlZ2S16sj
         JmU7Rsc6t6yAOtfcTch80eeV2clrSI/xset2YtXZQRlAt3RhENH66xIkrjrv5RZVpHH/
         B8BQDzu8PyIhMZ0Zxx0EzbKPiQF4QuqFkRif+TBQcSNPQ0VIOHZeBnnG0d62cK6/5b78
         AAPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790564065; x=1791168865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nxSV4vyNJBxBq3nFqrv4BdTyhQ8t7NPAkYwT/z/Lexg=;
        b=UragofS5xLZUFCwGXgBlyF2l3fZG9DWCTIcq3+8Pyi4m+WBNJNdCUUIORCh9UJ7iCP
         2GGMAb5SCezF6Swyb7Uxmw8hNb6DP85cN9XIGpmk9KRT0tVCjMahguUgorPdAxqxEhz4
         bxNnQUPwRepwn1pMnkO3ie9rIEG3hbIExYopPvPbZxS3mdQFcJbn5nazaQMIGZbhS5UW
         102qT6zLzgDu5ck/+ildgKcWBW+pX4omwByIFLztOyjMnRe/f3oXNsr6WbkVZsvjwAAE
         RMEqq/HUVR1MLeWRReNVuOq5hpcLLck3jaKHvbjSJ/9hogSzRvtv+lNkxlp5hZzuxupk
         VuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790564065; x=1791168865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nxSV4vyNJBxBq3nFqrv4BdTyhQ8t7NPAkYwT/z/Lexg=;
        b=G14KpcaPFFR0vKJFy3zlBBBPmKFc8NX7yz7pgjo0afDzV8Fa/B+sevVaKdwTbIsN73
         9vjIOGnpKKkkkcxLAuLR7UuO3agPjCdFucIXgxHmhjyj25pdErzWa6M6M/Ob1b7OQYiV
         UVCo/fnl0u1mQRl2Iru4/luNA8n52WSdeZEr2uiAUE2rlsC+mL2jXq2teQOwmBQXmZxZ
         IsK+pTWhK3wGyop6iOzARn6TTMIxZ0dL14ypLatHRLcyetHeRE8xC6uJxIVMMzOLawrq
         AvJcAmrW0lvA+Nq+2lUBnc9BS1A+f5iGJGBAfX6MoNJ/VLyi/+sh83kYE66BgJIefm1n
         5gow==
X-Forwarded-Encrypted: i=1; AKwUvBxiZtN04azE3weAyrwXtTy0ulWSPbqL0c8gnyKW0D992JRMeEJBXRd8Zcsd9Kj8DDAHLFg=@vger.kernel.org
X-Gm-Message-State: AFuF++k9ecH3qEgI6MFSZp3C/bsoNbMQv7G6vzXJCRsHVTrO6i/dARzZ
	FK4WKz0u5GtMkDwvBeYOWdE5mOxEtF7aKi7avDHhX03qUgXkyHAadfT4aobqXP1NFKOyFQ3pVnB
	8HH8/ph1GXNnGQLnu7UAel/xsa/JXtDk=
X-Gm-Gg: AYBFou1GYCFg0fAn/xVEGCMMnoz5s9RhcjT+RnAy68SYpn6GTiYw6SH1EXmNiKwapQl
	FvA3G/+U/TR9f2rjCJmlKPHbA+2/+/WGNeRQqhm7GDfqtfp1ifkj9tZpWwOkbIrBDAYUPpCIfgT
	GdYhLZdaQJlaUrWA7wY3R37+KhwH8Uk1kUTS+og8xTgXg3HGeT25HUHHHUkxtCgKzxgwhWkqDbE
	RI41UZqauEKNqUnM9TNmziGkJ4g0YMa4UwQ3GDBeVjYtOvZx8WWnhr/VfJA+ouadLuy6ygzC8zF
	j+ZzHT+WLGo1+yuM+5dRgB5YkQNTFaJpZjJkaafux2b4O/E5uquscs2egMm1seA+0EHfTAV0vaX
	h4FbNlRTwdB+L
X-Received: by 2002:a05:600c:37c4:b0:4a0:37a:10de with SMTP id
 5b1f17b1804b1-4a0037a12fdmr33868805e9.24.1790564064338; Sun, 27 Sep 2026
 19:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925133922.1356404-1-arnd@kernel.org>
In-Reply-To: <20260925133922.1356404-1-arnd@kernel.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 28 Sep 2026 10:54:13 +0800
X-Gm-Features: AclHuK-ou0kN-TRU45zS6iIgo2YpHfgWbBR4MR9NL98Ver5TOLd1c-E0Rut4bh8
Message-ID: <CAN_Opa8F+vKAAckVi0+qi_yXrav7Dop5brpS=zr7Hw-XaAUL2w@mail.gmail.com>
Subject: Re: [PATCH] rcu: include rtmutex_common.h in tree_stall.h
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Thomas Gleixner <tglx@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Andrea Righi <arighi@nvidia.com>, Cheng-Yang Chou <yphbchou0911@gmail.com>, 
	Gustavo Luiz Duarte <gustavold@gmail.com>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Arnd.

Tested on top of 1eccf02fb8d5 with CONFIG_PREEMPT_RCU=3Dy:

CONFIG_RT_MUTEXES=3Dy: build passes
CONFIG_RT_MUTEXES=3Dn: fails without this patch, passes with it

The failure is in tree_stall.h, where rt_mutex_owner() is used
before tree_plugin.h includes rtmutex_common.h. This matches the
reported failure, and the added include fixes it.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Tested-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

On Fri, Sep 25, 2026 at 9:39=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The added call to rt_mutex_owner() makes this fail to build in
> some configurations:
>
> In file included from kernel/rcu/tree.c:5121:
> kernel/rcu/tree_stall.h:333:8: error: call to undeclared function 'rt_mut=
ex_owner'; ISO C99 and later do not support implicit function declarations =
[-Wimplicit-function-declaration]
>   333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmute=
x) =3D=3D t)
>       |                             ^
> kernel/rcu/tree_stall.h:333:48: error: comparison between pointer and int=
eger ('int' and 'struct task_struct *') [-Werror,-Wpointer-integer-compare]
>   333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmute=
x) =3D=3D t)
>       |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~ ^  ~
> In file included from kernel/rcu/tree.c:5124:
> In file included from kernel/rcu/tree_plugin.h:14:
> kernel/rcu/../locking/rtmutex_common.h:231:35: error: conflicting types f=
or 'rt_mutex_owner'
>   231 | static inline struct task_struct *rt_mutex_owner(struct rt_mutex_=
base *lock)
>       |                                   ^
> kernel/rcu/tree_stall.h:333:8: note: previous implicit declaration is her=
e
>   333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmute=
x) =3D=3D t)
>       |                             ^
>
> There are already a couple of inclusions of "../locking/rtmutex_common.h"=
,
> so assume this is safe to do here.
>
> Fixes: 1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU tas=
k stall dump")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I wonder if it would be better to either move the rt_mutex_owner()
> definition into a global header like include/linux/rtmutex.h, or to
> move the code out of tree_stall.h into a .c file, as this feels like a
> layering violation.
> ---
>  kernel/rcu/tree_stall.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 5dded1e89197..803a56af3259 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -12,6 +12,7 @@
>  #include <linux/rcu_notifier.h>
>  #include <linux/smp.h>
>  #include <linux/rtmutex.h>
> +#include "../locking/rtmutex_common.h"
>
>  ////////////////////////////////////////////////////////////////////////=
//////
>  //
> --
> 2.53.0
>

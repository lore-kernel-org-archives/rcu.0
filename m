Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12E20ED;
	Fri,  6 Jun 2025 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749171777; cv=none; b=qe2A80ApBrLvff3gH7xr7ruiAHb6e/B3AKht9ht6uCZfA8cQYP6b+aQGuH1Ny31SHDDjb8eTbCeVtFWbWxwfRQeJZdyfHrEreuuxnnq5Pj8UVejV3RRhlPoxt2AlYy1hESrqRgorMkhNeJR6DkZ/NTGLPLy/3sgc6L83LhZV4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749171777; c=relaxed/simple;
	bh=Vj/qsKOEEWSN4falDnPojscfvOapD8cPA9kFY3aq+0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6MIyxxS2vmk6e9ejEjEnrbciYRCWlMrpKTcz0/JKEEK++dv3TK3GtyKraZvoXnJx4cJzehaVhc7p82MDZyy6rtGgyiG+7KsXPlVRysqde6bIfb5mtmtEriMMXIjdK31D+svTorIiFBf9JuVmEl+B8EDMFKcQRD0XXRJIJpHMKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krFkuBCo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krFkuBCo"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22e16234307so14798535ad.0;
        Thu, 05 Jun 2025 18:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749171775; x=1749776575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Clc6RKemK8i2fSRamfpfIS0oTwHwUYqe/vwec65dyxw=;
        b=krFkuBCo1TZ+qvAUb11uRnNumM3ywiHuIcscbImE8lL5FKFrJgaXaU3+YlLM2lz1w0
         47WHbUQGMm/I8P49KISiZd4RqYY78q3NsUemwpxEbpyf91t54f9asUxp1WYZh6xEPEyx
         903jzoK6ODEvrWjejz2wzeaqDcIhd0nWbJOufqAbkGtcVxXYa3Ekp8t8OHqrf+X/c2Tr
         S+pP+vrUzvltR61c9pfJiLAdLpfVPrWaSAv/mxkFkY+mJ15WMqJeve4XHfhCaHhYxWjo
         vvyaW/TZBi9yeRLImRbe2vDiDQ9IZFuKNAgz1TdAAi76X15/gghXtP7uhTpHovo3zDaa
         XIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749171775; x=1749776575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Clc6RKemK8i2fSRamfpfIS0oTwHwUYqe/vwec65dyxw=;
        b=QMM40tvHX14rGEhCzC+3SaseV60FwlgkfEeaOb7X74K2+R+VSIHBUpO+Pgk+f2OV6O
         wxka5ubPWvgY6mU4vhWZmjuN5MBRea2u5NhPz7FrqdVGv8YK894GR6cCpQ9BbEt0MuL4
         Q8JjA57GLTgtAN5nr2wv7SA2Oou5zmJqrY3YpUROBy1p7O6XORwQ/a2uvFr0qdHv/HBg
         ZilD9Rr7vzTMC4mJv3LIm5qKFH7m5l1RpBqYVYHvefvOHkcIgGIHsCiTSj/d+ySoyB8o
         myMfijWlNKgnS9RkvmqRXMWVxi4hOazJETsl/yy/vvzGHlLF82D0+pRTKBUS9WRINcFA
         mfnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUww53YRt3T6IzT/yrFmeTgbjSYL/VX5OpBTEFksb209cYD4TjHMwF5zXAmK3VoEiXXVW1PCSUstsMFr98=@vger.kernel.org, AJvYcCWjWHpWefJ3Vc121FfyoaXXddV5N9cB4shTiXA5OMVFPz7EdcSpOIhQ5JFeqPVPPNnNHmh8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2xS3pZygfAlnnYOzi5KWwX914jiFlNXb4jNtaUU7aEQJ5BXRQ
	VIfNEtTyoPokyC7EQx4z4zUnYFX2ZFx/vi8m1PCWcsoSlObXftej2KlvuANIBaE5MIJL4+0uqMP
	X3rUwiEajn95LaQwYmdxgnuV93ojzXUA=
X-Gm-Gg: ASbGncs4T9hdhppfzZccDFf9PHjCln5S3b5YY6NInQPgjlUxyPx+Wdqk3bcMZuVwpAl
	OnKuiiSdHlsoTVmirzXMKJaZlzl5dRsPmU9BEevl0yom50DY24eXMjEHqtpX+42PDszEDCzUKla
	T9Txpx40M9cd8wE/6/Kbdffudwh/wme/2Dkg==
X-Google-Smtp-Source: AGHT+IE5FBNEV/47k/4JKzJRzryDTEf3p+kMGolYhQ772J0KrTpmzVvrg6wRxbCOkqHt3dCn7qP2TvREr62YFNr96iE=
X-Received: by 2002:a17:903:2288:b0:234:11e2:f41 with SMTP id
 d9443c01a7336-236039c40b1mr8461895ad.6.1749171774904; Thu, 05 Jun 2025
 18:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519203540.GA3639139@joelnvbox>
In-Reply-To: <20250519203540.GA3639139@joelnvbox>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Fri, 6 Jun 2025 09:02:45 +0800
X-Gm-Features: AX0GCFtC3KbgqjPk19e8bwueZ3K1bW53m8D6s3eeZnXTAXzkslRvwIOSur7FtM4
Message-ID: <CALm+0cX+12GsZh+vJd_OZanOxWYLuQTfiDyM=v3xSDy99CkdYA@mail.gmail.com>
Subject: Re: RCU changes for v6.16
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Hi Linus,
>
> When the merge window opens, please pull the RCU changes for v6.16:
>
> The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089a=
c8:
>
>   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/next.2=
025.05.17a
>
> for you to fetch changes up to 9c80e443379861a6b374db3c5bb830167cbe0676:
>
>   Merge branches 'rcu/misc-for-6.16', 'rcu/seq-counters-for-6.16' and
>   'rcu/torture-for-6.16' into rcu/for-next (2025-05-16 11:18:16 -0400)
>
> We in the RCU maintainers crew have done rigorous testing of these patche=
s on
> both x86 and ARM, big and small machines, to ensure high quality so I am
> confident this will go smoothly. Thanks!
>
> ----------------------------------------------------------------
> RCU pull request for v6.16
>
> Summary of changes:
> - Removed swake_up_one_online() workaround
> - Reverted an incorrect rcuog wake-up fix from offline softirq
> - Rust RCU Guard methods marked as inline
> - Updated MAINTAINERS with Joel=E2=80=99s and Zqiang's new email address
> - Replaced magic constant in rcu_seq_done_exact() with named constant
> - Added warning mechanism to validate rcu_seq_done_exact()
> - Switched SRCU polling API to use rcu_seq_done_exact()
> - Commented on redundant delta check in rcu_seq_done_exact()
> - Made ->gpwrap tests in rcutorture more frequent
> - Fixed reuse of ARM64 images in rcutorture
> - rcutorture improved to check Kconfig and reader conflict handling
> - Extracted logic from rcu_torture_one_read() for clarity
> - Updated LWN RCU API documentation links
> - Enabled --do-rt in torture.sh for CONFIG_PREEMPT_RT
> - Added tests for SRCU up/down reader primitives
> - Added comments and delays checks in rcutorture
> - Deprecated srcu_read_lock_lite() and srcu_read_unlock_lite() via checkp=
atch
> - Added --do-normal and --do-no-normal to torture.sh
> - Added RCU Rust binding tests to torture.sh
> - Reduced CPU overcommit and removed MAXSMP/CPUMASK_OFFSTACK in TREE01
> - Replaced kmalloc() with kcalloc() in rcuscale
> - Refined listRCU example code for stale data elimination
> - Fixed hardirq count bug for x86 in cpu_stall_cputime
> - Added safety checks in rcu/nocb for offloaded rdp access
> - Other miscellaneous changes
>
> ----------------------------------------------------------------
> Frederic Weisbecker (3):
>       rcu: Comment on the extraneous delta test on rcu_seq_done_exact()
>       rcu: Remove swake_up_one_online() bandaid
>       Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"
>
> I Hsin Cheng (1):
>       rust: sync: rcu: Mark Guard methods as inline
>
> Joel Fernandes (7):
>       MAINTAINERS: Update Joel's email address
>       rcu: Replace magic number with meaningful constant in rcu_seq_done_=
exact()
>       rcu: Add warning to ensure rcu_seq_done_exact() is working
>       srcu: Use rcu_seq_done_exact() for polling API
>       rcutorture: Perform more frequent testing of ->gpwrap
>       rcutorture: Fix issue with re-using old images on ARM64
>       Merge branches 'rcu/misc-for-6.16', 'rcu/seq-counters-for-6.16' and=
 'rcu/torture-for-6.16' into rcu/for-next
>
> Paul E. McKenney (12):
>       rcutorture: Make srcu_lockdep.sh check kernel Kconfig
>       rcutorture: Make srcu_lockdep.sh check reader-conflict handling
>       rcutorture: Split out beginning and end from rcu_torture_one_read()
>       rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT
>       doc: Update LWN RCU API links in whatisRCU.rst
>       rcutorture: Comment invocations of tick_dep_set_task()
>       checkpatch: Deprecate srcu_read_lock_lite() and srcu_read_unlock_li=
te()
>       torture: Add --do-{,no-}normal to torture.sh
>       torture: Add testing of RCU's Rust bindings to torture.sh
>       torture: Check for "Call trace:" as well as "Call Trace:"
>       rcutorture: Reduce TREE01 CPU overcommit
>       rcutorture: Remove MAXSMP and CPUMASK_OFFSTACK from TREE01
>
> Su Hui (1):
>       rcuscale: using kcalloc() to relpace kmalloc()
>
> Wei Yang (1):
>       doc/RCU/listRCU: refine example code for eliminating stale data
>
> Yongliang Gao (1):
>       rcu/cpu_stall_cputime: fix the hardirq count for x86 architecture
>
> Zqiang (2):
>       MAINTAINERS: Update Zqiang's email address
>       rcu/nocb: Add Safe checks for access offloaded rdp

Hi Joel

Should the following patch also be included in 6.16?

rcutorture: Fix rcutorture_one_extend_check() splat in RT kernels.

Thanks
Zqiang



>
>  Documentation/RCU/listRCU.rst                      |  10 +-
>  Documentation/RCU/whatisRCU.rst                    |   3 +
>  Documentation/admin-guide/kernel-parameters.txt    |  25 +++
>  MAINTAINERS                                        |   8 +-
>  kernel/rcu/rcu.h                                   |  18 +-
>  kernel/rcu/rcuscale.c                              |   2 +-
>  kernel/rcu/rcutorture.c                            | 206 +++++++++++++++=
+-----
>  kernel/rcu/srcutree.c                              |   2 +-
>  kernel/rcu/tree.c                                  |  84 +++++----
>  kernel/rcu/tree.h                                  |   3 +-
>  kernel/rcu/tree_exp.h                              |   2 +-
>  kernel/rcu/tree_nocb.h                             |  10 +-
>  kernel/rcu/tree_plugin.h                           |   2 +-
>  kernel/rcu/tree_stall.h                            |   4 +-
>  rust/kernel/sync/rcu.rs                            |   5 +
>  scripts/checkpatch.pl                              |   2 +
>  .../selftests/rcutorture/bin/console-badness.sh    |   2 +-
>  .../selftests/rcutorture/bin/kvm-test-1-run.sh     |   2 +-
>  .../selftests/rcutorture/bin/parse-console.sh      |   2 +-
>  .../selftests/rcutorture/bin/srcu_lockdep.sh       |  42 ++++-
>  tools/testing/selftests/rcutorture/bin/torture.sh  |  89 ++++++++-
>  .../selftests/rcutorture/configs/rcu/TREE01        |   2 -
>  .../selftests/rcutorture/configs/rcu/TREE01.boot   |   2 +-
>  23 files changed, 403 insertions(+), 124 deletions(-)

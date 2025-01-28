Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB85148314;
	Tue, 28 Jan 2025 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056776; cv=none; b=CIXg2FlT6z4bZ+f8lYReKoBxD20jpoyw90ObWd3OWDE+EYAPPlrU2P1iVq+SIspbWO8x/oFomRRYPxSipcUwMa0QltVdHlfPxDJImHEkqa8zDcEnI6IzGDA0rN8Yyn8hUUvciN8AZ1RoT5VArR9ggPis6wPne8U8ZovLtHoGmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056776; c=relaxed/simple;
	bh=hboS82pEFLbWL7a1TNFrICTcPpADScRg1xzaDz56Z34=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4hmS+SMyvcOf/5bezMHVRc1GoZOtfn4cvg3yqdvdbXGjoLjBNrfsLazM7Nw0roZb0qz8oTGCMbFVK7njdPsZrTkSKGkqc0sHalcuZLX7Y8LGOb1Nvgf6ZxQU6Q/RdzBK1lOTH5vrBfTLVa0tFszoog06ljbW3XmlxcNesoL5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDPCkoj+; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDPCkoj+"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e384e3481so5164780e87.2;
        Tue, 28 Jan 2025 01:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738056773; x=1738661573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AHylwtXEsThVCOOBm9m9DKLn+bla2GFl7GBdBgMfkF4=;
        b=BDPCkoj+CboUid3qWNivLQOMbkLKs+IO5mWOJnld268jRZzF3xv3cGPPzUtwXGUv2D
         HYh28qOgsRMis+DcWVfKL5cspPeLR779CHkp+nIlOfsyjzfqDtwjn3dnMo7K44d8TJnk
         9NJGP1hfQe+fPv5AoRWB35vrHHiMFf/Po2VJuvToTX66px5xFM6pfNubnqL3S43BO1cO
         iVQgOucVpgKDzeEFLXGbaaq8xLUkQ1ANNV39LJGAGpKwO8+DsFYPH5bFknaOp4Mlqe5t
         POCRAmVTMXAwmlzbHAmA2p4CF0QF7KOzFehrgW5yItjhB/TsI+cJaxlt0r7KfaLnaBD9
         bMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738056773; x=1738661573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHylwtXEsThVCOOBm9m9DKLn+bla2GFl7GBdBgMfkF4=;
        b=bFEdwGAWUluVg39hNAPsfyKxLalUKsyEsBovuoIGQMMgVu+vXh34l4MQavAfSfTSCa
         Z95otI488h8mR1O4QT20tu9REXbSRHe4I8D5qUCPnv7yiOZJgGpQSdfn7WmwLRl16F+A
         vOUEUqiLBZJdM2KmX4i/VNWUKY9E37315sLjQ/2FYXmFSZ048lGe92Uz4HRqxf64F3d9
         Y7paN3B2KJN7eoLzYCVD2uPiRbey+7to1BwgJdAuhqAUDCu2GuzuWg6ocvH3OrzGaV3C
         NDnbezYTHx1Dkl1XaALoDe43GdB/FqvapqsrueUPd12mfxR2evM2p9Mbi9IpWZQ8axMM
         RKfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbhR0tWF6PxVm+97vMpIqOjwHVbs85uJXrFRkaBUptnog9kcroMYTv+ZqR26E479304HYnc765wDmTCUw=@vger.kernel.org, AJvYcCXNBrBHzmCz0MI2Gop4QuwrCi/UcMt96iL++ttospx/RUcMbpbfRglevBOPpQ1qo/bmyzbU@vger.kernel.org
X-Gm-Message-State: AOJu0YwgCr9KdB6jNwh5CU8BLSAMvrFkDFejkDoOUlMuHDj5TJdkDa89
	CF03JkWHEGJldXwJRO1Otszdrm0fS4SDMHgjk/mMuBNLRkrf7Sl+
X-Gm-Gg: ASbGncuIQCv1ABpBXOb/GPLYELKYmQD/vF2rUvbillA1CUnlJBiu2QyfNfS9z0jRZCr
	7JJXXEgHHFRyNZIcWn3y6gGhOKE0ZbM2hTDb1JJa/wmxcFuwcQCqyEJq1ZsHIUVvu4idt08yDEY
	+T+onfL74IsgE/WF7cFSLfSINOABf0jPW51R4B1zBR27RroCAYd9894PwW8M8gz4ZTYeAWESzV6
	1Fj07zSs+w15jjVA3hYuCnBIDjq9WdarLBNGGRLarZmHn51cXC65ndBd/e2ZXoZN8dE1igCDUB1
	65HFBww4bheQBlx1IAHJZzABW/mTCdiUAMf1kUr4aN8=
X-Google-Smtp-Source: AGHT+IFlypY7o/LYpErFVtLkLA0wpLa+JRarBPX3snjlcwhNXRmo4Glc45J/cNjDBCVGCyFR/cdbIQ==
X-Received: by 2002:ac2:5df8:0:b0:53e:383a:639a with SMTP id 2adb3069b0e04-5439c26762dmr13249619e87.37.1738056772572;
        Tue, 28 Jan 2025 01:32:52 -0800 (PST)
Received: from pc636 (host-95-203-24-189.mobileonline.telia.com. [95.203.24.189])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8237464sm1607775e87.105.2025.01.28.01.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 01:32:52 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 28 Jan 2025 10:32:49 +0100
To: cheung wall <zzqq0103.hey@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: cheung wall <zzqq0103.hey@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: "WARNING in rcu_sr_normal_complete" in Linux Kernel v6.12-rc4
Message-ID: <Z5ikQeVmVdsWQrdD@pc636>
References: <CAKHoSAvbRnktnM=H52eNe0QQryP908Q612Hfxzy2sozUdHRrjQ@mail.gmail.com>
 <Z4kRzMO03mwjqCu2@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4kRzMO03mwjqCu2@pc636>

On Thu, Jan 16, 2025 at 03:03:56PM +0100, Uladzislau Rezki wrote:
> Hello, Cheung Wall!
> 
> > 
> > I am writing to report a potential vulnerability identified in the
> > Linux Kernel version v6.12-rc4. This vulnerability was discovered
> > while i was testing the kernel.
> > 
> > Linux Kernel Repository Git Commit:
> > 42f7652d3eb527d03665b09edac47f85fb600924 (tag: v6.12-rc4)
> > 
> > Bug Location: 0010:rcu_sr_normal_complete+0xd0/0x110 kernel/rcu/tree.c:1638
> > 
> > Bug report: https://pastebin.com/kuJ7wnPe
> > 
> > Entire Log: https://pastebin.com/fT42ya0T
> > 
> > Thank you for your time and attention.
> > 
> Do you have a reproducer of this splat?
> 
The reproducer is below:

for (( i=0; i<$LOOPS; i++ )); do
	tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --configs \
	'16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1' \
	--kconfig "CONFIG_NR_CPUS=4"

	echo "Done $i"
done

Please note, it also requires to modify TREE05:

+# This part is for synchronize_rcu() testing
+rcutorture.nfakewriters=-1
+rcutorture.gp_sync=1
+rcupdate.rcu_normal=1
+rcutree.rcu_normal_wake_from_gp=1

and:

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d26fb1d33ed9..6bc161e1e8ac 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4050,6 +4050,10 @@ rcu_torture_init(void)
                                          writer_task);
        if (torture_init_error(firsterr))
                goto unwind;
+
+       if (nfakewriters < 0)
+               nfakewriters = (int) num_possible_cpus();
+
        if (nfakewriters > 0) {
                fakewriter_tasks = kcalloc(nfakewriters,
                                           sizeof(fakewriter_tasks[0]),

--
Uladzislau Rezki

Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4FF78C8B
	for <rcu@vger.kernel.org>; Tue, 22 Oct 2024 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614770; cv=none; b=i9hlgsq2eGpbZtepoQwRxdOH0uIVMTlui2dRgXk+159JqTF10QKUOxNMjxTqINRZlqbX7IDLFOJk6i1OXEVgLy30qgrzSy1kRiMFHdzaEf01ZJkGtR/kRS+dPXLar5DFtlj0s1AntYdtA7Tn/AE6Z9WeYV3Hw6xad8arvzJpkWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614770; c=relaxed/simple;
	bh=vBI7GZCDRsxWBviqRxiYMMp4mmPZ3rqArJNZXBvKf0g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6VxFo5EOSXruA9F4SkmHAQWPQw07T7AUMvW/YK4jAI1aYfH8ai7Nm5m/mTNpnW+fDMD4y2zVnxkrqw3d7uLPKFmF2RFOv6nihRrlxtG98cDcJegmKBSREH/Nfo1k7OEPEgOXeJlxtQ5JvWB7PYjljqDOU+10evtF3WF4wHcSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zj7wuKEb; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj7wuKEb"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e8586b53so5821589e87.1
        for <rcu@vger.kernel.org>; Tue, 22 Oct 2024 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729614767; x=1730219567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2QfIlTohuo8iuwEecqhI4hQbQXMcr01uBoEUYBnVPaI=;
        b=Zj7wuKEbNmB/sLskF7SuFzzWA0d52lkbJPS3R/FjPHf6Q0ZjnlAUXP5rWnDywd/Fzf
         KPo/sbSJNhqzu4pTG7iPdpLx8j8myTWo/M/W/Bx2BtMn1FIhdyHt0l0fRZDq497iK5Sk
         ZLWuvkArtO+YTW3NoA0tN3FVx1Boa2JOgTi89Wos1h3eXoXwkqsfhC+DanXDXx15v4+x
         IBbWjnbo47KBOjT35owVnRGIVB7NJikHi8UXIvcstQf8ulSQonvRszFrniD16V7M9Y3U
         E607XKDXiRDOJsFgP0/+Ce8WPnC0B84Hg61plHdIkjhLxYphpc+QszDm1F902/ROtC68
         Pp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614767; x=1730219567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QfIlTohuo8iuwEecqhI4hQbQXMcr01uBoEUYBnVPaI=;
        b=BWtn09CS8N+Y6oo0l+8Nvhfx+r7JNFQWKilY4oNIrldpC4jg6E2pihji4Ye1BCgIxR
         XOf08ixqwqMUYSv0K6pRcVQtEmbTHC2U4432pNjxy1jdUu/0hH6i8voiH6GcWoe7IDi/
         kniQNn5yYng8m19XaoSZNQylKjXhCmYfFVqfpfSzk+XZgHcDwDjmUdDagLoJDhx6bZ+o
         Kh9wea0BcIoSH3prOHucj2O6uatmr2La1FZDJsI2WOMnx4IlV/GEasbPcqGorMaBk0hB
         ixuHtYdc31xR5k586bt+BZNpNGyxOpPoWDHx+Z06KTp1QdqVDMtz7KYU1Z5XE8gevmnx
         d//w==
X-Forwarded-Encrypted: i=1; AJvYcCWFuYamEYOXt9UR6LYmkFz6f5iEQAxrZQtqwKUMraS+HgAfQLm706rW9yoKO4A3GXoO/ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEoP4HLAjBHlUArBi8aEPQqPlUAXo20hLcKqJppW3NrChNaZpI
	q1LnJzjosq0GHxh5VZd1z9T8PwvI5AMIhacJhOzp3euS+/tiKM9+
X-Google-Smtp-Source: AGHT+IGpIApWvaszRRc3SItpDZiKiEd3nsSUxm4bLNw0yi7fPB+qTV7/7nXVe8wzluQSXG1QIHGQLQ==
X-Received: by 2002:a05:6512:691:b0:539:fcaa:d0ca with SMTP id 2adb3069b0e04-53b13184a8emr1404364e87.13.1729614766466;
        Tue, 22 Oct 2024 09:32:46 -0700 (PDT)
Received: from pc636 (host-90-233-221-2.mobileonline.telia.com. [90.233.221.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223f00f3sm825475e87.95.2024.10.22.09.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:32:46 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 22 Oct 2024 18:32:44 +0200
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [bug report] rcuscale: Add laziness and kfree tests
Message-ID: <ZxfTrHuEGtgnOYWp@pc636>
References: <27bbe8bd-ef47-49a9-b094-89ab951e33ae@stanley.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27bbe8bd-ef47-49a9-b094-89ab951e33ae@stanley.mountain>

On Tue, Oct 22, 2024 at 12:07:01PM +0300, Dan Carpenter wrote:
> Hello Joel Fernandes (Google),
> 
> Commit 084e04fff160 ("rcuscale: Add laziness and kfree tests") from
> Oct 16, 2022 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	kernel/rcu/rcuscale.c:1215 rcu_scale_init()
> 	warn: inconsistent returns 'global &fullstop_mutex'.
> 
> kernel/rcu/rcuscale.c
>    857  kfree_scale_init(void)
>    858  {
>    859          int firsterr = 0;
>    860          long i;
>    861          unsigned long jif_start;
>    862          unsigned long orig_jif;
>    863  
>    864          pr_alert("%s" SCALE_FLAG
>    865                   "--- kfree_rcu_test: kfree_mult=%d kfree_by_call_rcu=%d kfree_nthreads=%d kfree_alloc_num=%d kfree_loops=%d kfree_rcu_test_double=%d kfree_rcu_test_single=%d\n",
>    866                   scale_type, kfree_mult, kfree_by_call_rcu, kfree_nthreads, kfree_alloc_num, kfree_loops, kfree_rcu_test_double, kfree_rcu_test_single);
>    867  
>    868          // Also, do a quick self-test to ensure laziness is as much as
>    869          // expected.
>    870          if (kfree_by_call_rcu && !IS_ENABLED(CONFIG_RCU_LAZY)) {
>    871                  pr_alert("CONFIG_RCU_LAZY is disabled, falling back to kfree_rcu() for delayed RCU kfree'ing\n");
>    872                  kfree_by_call_rcu = 0;
>    873          }
>    874  
>    875          if (kfree_by_call_rcu) {
>    876                  /* do a test to check the timeout. */
>    877                  orig_jif = rcu_get_jiffies_lazy_flush();
>    878  
>    879                  rcu_set_jiffies_lazy_flush(2 * HZ);
>    880                  rcu_barrier();
>    881  
>    882                  jif_start = jiffies;
>    883                  jiffies_at_lazy_cb = 0;
>    884                  call_rcu(&lazy_test1_rh, call_rcu_lazy_test1);
>    885  
>    886                  smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL == 1);
>    887  
>    888                  rcu_set_jiffies_lazy_flush(orig_jif);
>    889  
>    890                  if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
>    891                          pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
>    892                          WARN_ON_ONCE(1);
>    893                          return -1;
>                                 ^^^^^^^^^^
>    894                  }
>    895  
>    896                  if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
>    897                          pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
>    898                          WARN_ON_ONCE(1);
>    899                          return -1;
>                                 ^^^^^^^^^^
> The checker is complaining that we don't call torture_init_end().  Should these
> do a goto unwind?  Otherwise we're left holding the fullstop_mutex.
> 
Not really. At least if we want to "goto unwind", the following patch
should be applied:

<snip>
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 6d37596deb1f..4eb872f9acd9 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -818,7 +818,8 @@ kfree_scale_cleanup(void)
 
 	if (kfree_reader_tasks) {
 		for (i = 0; i < kfree_nrealthreads; i++)
-			torture_stop_kthread(kfree_scale_thread,
+			if (kfree_reader_tasks[i])
+				torture_stop_kthread(kfree_scale_thread,
 					     kfree_reader_tasks[i]);
 		kfree(kfree_reader_tasks);
 		kfree_reader_tasks = NULL;
@@ -890,13 +891,15 @@ kfree_scale_init(void)
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
 			WARN_ON_ONCE(1);
-			return -1;
+			firsterr = -1;
+			goto unwind;
 		}
 
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
 			WARN_ON_ONCE(1);
-			return -1;
+			firsterr = -1;
+			goto unwind;
 		}
 	}
<snip>

then it should address your "static checker warning" which looks correct
to me.

@Joel, @Paul, do you agree? If so i can prepare the patch.

--
Uladzislau Rezki

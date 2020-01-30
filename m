Return-Path: <SRS0=LYSJ=3T=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6B6C2D0DB
	for <rcu@archiver.kernel.org>; Thu, 30 Jan 2020 14:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D7E20658
	for <rcu@archiver.kernel.org>; Thu, 30 Jan 2020 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580393470;
	bh=G0gBjAny5yN8fGZvT15qlodFm7KjouPKenaASKGMRxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LL6MyGYBDLb9LJb9Bi37ct6UP3xUXfn6LwoYVbqIAXFw2N4dR4FF6Y0/072GeoQMM
	 CzQPdi2uTWteRrp/IwqXgR2NJe56GgpWxelLJ6bZ5mnlOx8PCZGNduSZbnTmMZHycC
	 tXRPciBRpg8Jj3j7M94WrTQ0hHze/jD9qSwNqZyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgA3OLK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:11:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51947 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgA3OLK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jan 2020 09:11:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so3928589wmi.1;
        Thu, 30 Jan 2020 06:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q4JcWlTe/zyFu8ktXOL2ermwd8PkUTZPqu99fFqglok=;
        b=PELddM3/DNwRWFFCa+0FQswbMO1Du5Ln/pkQSTMxbiSJLDaoSkZJ/6MoNySi6BaEbY
         RPsApofmJvjg6ahjIdGGDf3K97cGkDLV+qy1qvJgG0zhpGzbxrk4HH7Qj2fScRZjnui3
         qoPURYZjzHn+WDDTe4g1kiPzGsx4sS1pEBtCT9vC4YGEYVYgJDzmINdlNv6erAmjg1cf
         6u9lzqPPFK+DYbmQBlMiYxskmKnDPyKIgJ4IxZWRCVBHHU0MQ6fldFU3vtgO1DziovBA
         hECydFHqgzr+IrkWHltOJdvwQQJNs9G1j/knKsNN5U3mQLq86ezg7rYNxqUUgpXQ86kp
         UQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q4JcWlTe/zyFu8ktXOL2ermwd8PkUTZPqu99fFqglok=;
        b=J77YJo6VKN2Dncy2ySAXo0SYLVM4jJYS81h8D+BFAD9aJpRNfvT1PSSwb2lgics6Ah
         M9kw6liAuBbYW+OjXFNv26S+Vjb2D102W54WH+DVUXNVQZI6DohRXBqTzaWGxoYQQT0z
         vmBe7/5HfZ22MvRK/pY/hzFdTJed1RBi7RHU7uhDBBDL8uo4A3hchUWl+wgGK5UIlVwN
         v9GLZZ5tu+5lf3mu8Xu2oZCW+YkOFdCSQ1Z0VJ8zPU4dhOReuSayRUU9e0POo4gAttkm
         cfbjL/jnHt+zLGJuN4cbuhVVHpqRXCGUDZ8sVAc0lgJBmVXRPxO1nuRPZVXqKl7d8f+v
         xZoA==
X-Gm-Message-State: APjAAAUWMOIbO17Updq8VtcM9FqKgOxpNkpWW+g4ovqqdfmZAWtiGy0t
        fANAjLRJqG+W8LrWMlF6djo=
X-Google-Smtp-Source: APXvYqwouINwxupUGjm9+xYVizQvCNu2xbJw/0I+bZf+JGGE9mwkWx4GM3izcsSlc52BkQdbWxWTsg==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr5837435wmd.23.1580393467708;
        Thu, 30 Jan 2020 06:11:07 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i16sm6998338wmb.36.2020.01.30.06.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 06:11:07 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:11:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL tip/core/rcu urgent] RCU fix for boot-time splat
Message-ID: <20200130141105.GA130017@gmail.com>
References: <20200129120206.GA15554@paulmck-ThinkPad-P72>
 <CAHk-=whK-nw7PizDEzMgKwQQ6H5NXg0=NTwb6ECDb5PfchFQjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whK-nw7PizDEzMgKwQQ6H5NXg0=NTwb6ECDb5PfchFQjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Jan 29, 2020 at 4:02 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Hello, Ingo,
> >
> > This pull request contains a single commit that fixes an embarrassing
> > bug discussed here:
> 
> Ingo, just FYI: I'll just take this pull directly, just to avoid
> having the warning in my current tree.

Thanks!

	Ingo

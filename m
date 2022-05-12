Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE1DC433EF
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 14:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348903AbiELOiA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 May 2022 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiELOh7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 May 2022 10:37:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D18C5E74
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 07:37:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p26so9426295lfh.10
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qRKpj5cn+XkCHlnN6ZtWD1uwgrjdbB8OQsR7HTU9ZTg=;
        b=IGDyW28QGpJZWL4UeagEp+Fah8WvY4f2VzNSY3MMiCwa/9ZSZ0NHKk1dbonL0QhXVT
         hJ/v5rGm4YuPnC54H+ktTIC97yk8IluRi12c4r4Epp5xgsB7UBbB7fAhmBiP6ipfXIPu
         TI6YRMQVuxmqFFZ4MTF8WawRpggK6XwJfXvFwuLXm2sRErKuRQoEkCxsXqk/DjyVObvs
         5O7DoLbCE6QgQcuqIqeCKnxxwb9JL33tkK2OhO56KMmbDSqpIMAedYa7F3WFj4dbsyQw
         A40W2GakVwxNWogohbZp4L7nkF6sHzINyFmSZgka/ttoYYAl/B8V/0fzuxXUo5gDMaa8
         b74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qRKpj5cn+XkCHlnN6ZtWD1uwgrjdbB8OQsR7HTU9ZTg=;
        b=UyUL23P9M6s0PoX98OYdiwNLWQDHDISKwBYoxuHvbxYTYct1Mvl2H1i9Swt/TVJ/iM
         Ztnlg6GsORI2iIT5ZEUto0VOT+HIUIiR7nQHKfJsizmBNgZGP2Ns7TOrbmGqtAgdUypq
         q/Kx/TEs3RNSKP679UCmDv7tJcAB3/edF2PyAgT2BFnaYPwC5tJf4Io09y6gjAEEeJS0
         L0rtWgYPIlbJQiWKElNiqDtAGrmoz3H1GV9VyXps8xDSU/+vOu+g7L25wF79PRGmjOKI
         MRXDa79ieZIZtSNIIYaYroDTeHAw87RX/v7fN//6F9njz2l684si/IrD7yiox+gYwgVU
         lBjw==
X-Gm-Message-State: AOAM531ELGxPOrhyStBITIhOmB2R+K+W+15KkmRwzdCtRAiEp95/cfw0
        AvJc/ghAprr4pvi7Qy0HQM4=
X-Google-Smtp-Source: ABdhPJx/gT29xVLauTI7cZp7fRVZtn5qc6wcXk4CoilfFee8TP524uOD+yPTKq/rCcgh/lMjP7dBLA==
X-Received: by 2002:a05:6512:2295:b0:473:b840:75f3 with SMTP id f21-20020a056512229500b00473b84075f3mr48660lfu.513.1652366276913;
        Thu, 12 May 2022 07:37:56 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id bg32-20020a05651c0ba000b0024f3d1dae9fsm911520ljb.39.2022.05.12.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:37:56 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 12 May 2022 16:37:54 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <Yn0bwhkdfPvbjIwK@pc638.lan>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com>
 <CA+KHdyVTwtC274v=Mmbwe3jaRPsme1mENWiOR+m2uDV=3SBTBQ@mail.gmail.com>
 <CA+KHdyVGCC2-S8waURWL_cwjdv8EyeUwnLFNVYHn+h7TrteP6g@mail.gmail.com>
 <Yn0TuehXj6VoWG0A@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn0TuehXj6VoWG0A@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> On Thu, May 12, 2022 at 03:56:37PM +0200, Uladzislau Rezki wrote:
> > Never mind. I port it into 5.10
> 
> Oh, this is on mainline. Sorry about that. If you want I have a tree here for
> 5.10 , although that does not have the kfree changes, everything else is
> ditto.
> https://github.com/joelagnel/linux-kernel/tree/rcu-nocb-4
> 
No problem. kfree_rcu two patches are not so important in this series.
So i have backported them into my 5.10 kernel because the latest kernel
is not so easy to up and run on my device :)

--
Uladzislau Rezki

Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA14C4167B
	for <rcu@archiver.kernel.org>; Fri, 16 Dec 2022 16:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiLPQco (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Dec 2022 11:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiLPQcn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Dec 2022 11:32:43 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4F4E3B
        for <rcu@vger.kernel.org>; Fri, 16 Dec 2022 08:32:41 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id s9so3082108qtx.6
        for <rcu@vger.kernel.org>; Fri, 16 Dec 2022 08:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWTKvq0Z8Lun5k4EX7m861ECUbu18rBFF3DYFc725RY=;
        b=pN2JdeL0UXzd0Dvw69uGbyO7tEP5Z75yckU+lEI9GqWB2dwXfjqmoTqGgVNJzAStVW
         HbzM3PlWFRmHdb42JC/0VgGu96m7oXL6hCh8wHsa3vk0+xxCa78smCePNcfotnhMSBpq
         /QuECKwer8WkZpESIRjEsUQGLbXIQ1jQkB3X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWTKvq0Z8Lun5k4EX7m861ECUbu18rBFF3DYFc725RY=;
        b=lNOlxG6QNcGvTkqkJ19oz8Bz5mdBGRm8YlRXjQU1PChM/hxzSnlIsj/a2eYXpZyU2l
         Fn5JUOAXgp4WX22PBkKNLl1JOxWVZ6kWfwIxg1LcS9V4ciTfTTycwXlyWXMQOu0YE5qI
         MmSf5muhNvrbipoD3tjkXcoyryUc4hGfH258xbJ56yVoXiB2xVOmyP5UaeMR4BX1L5Sm
         5hWquOVL85cV2w64Gk2Nf1H96Yg6cRa9NuwHd7PY5NM7sKnP/zsanZrZPS8hYYZJPZgY
         9DV2eC4qjkZ80ZL57SZxb6+sd9CCQlpaCxyYY0Uu5JMvDwqix6tcHfAuT4JAMa26aMSl
         lAMw==
X-Gm-Message-State: ANoB5pmm+tL/ULuARrMK5xmE2e9reN3gyyXvBwT8WbdYPFAG1eItmvVL
        Y0sWgy7AJYTNP+pF4LO/rbc0W7q4uHGmmqdQpRM=
X-Google-Smtp-Source: AA0mqf6EAnHcIVAw94wyGebCIhI6qcQwBvfweRpFyWYod0KCt4TMiZOpuPrTAWnKpCwZpJ/UeBgy4w==
X-Received: by 2002:ac8:1084:0:b0:3a8:2e:ea22 with SMTP id a4-20020ac81084000000b003a8002eea22mr39513623qtj.44.1671208360762;
        Fri, 16 Dec 2022 08:32:40 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x13-20020ac8120d000000b003a6847d6386sm1536318qti.68.2022.12.16.08.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:32:40 -0800 (PST)
Date:   Fri, 16 Dec 2022 16:32:39 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <Y5ydp2YPRqGHq+eM@google.com>
References: <20221215201356.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <EE4EC3CC-395E-475D-BEBE-545955AB97C8@joelfernandes.org>
 <20221216010914.GX4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216010914.GX4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Dec 15, 2022 at 05:09:14PM -0800, Paul E. McKenney wrote:
[...]
> > >> 2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the reader
> > >> has no new smp_mb() that happens AFTER the flip happened. So it can
> > >> totally sample the old idx again -- that particular reader will
> > >> increment twice, but the next time, it will see the flipped one.
> > > 
> > > I will let you transliterate both.  ;-)
> > 
> > I think I see what you mean now :)
> > 
> > I believe the access I am referring to is the read of idx on one side and
> > the write to idx on the other. However that is incomplete and I need to
> > pair that with some of other access on both sides.
> > 
> > So perhaps this:
> > 
> > Writer does flip + smp_mb + read unlock counts [1]
> > 
> > Reader does:
> >  read idx + smp_mb() + increment lock counts [2]
> > 
> > And subsequently reader does
> > Smp_mb() + increment unlock count. [3]
> > 
> > So [1] races with either [2] or [2]+[3].
> > 
> > Is that fair?
> 
> That does look much better, thank you!

Perhaps a comment with an ASCII diagram will help?


Case 2:
Both the reader and the updater see each other's writes too late, but because
of memory barriers on both sides, they will eventually see each other's write
with respect to their own. This is similar to the store-buffer problem. This
let's a single reader contribute a maximum (unlock minus lock) imbalance of 2.

The following diagram shows the subtle worst case followed by a simplified
store-buffer explanation.

READER                  UPDATER
-------------           ----------
                           // idx is initially 0.
read_lock() {
  READ(idx) = 0;
  lock[0]++; --------------------------------------------,
                           flip() {                      |               
                              smp_mb();                  |
  smp_mb();                                              |
}                                                        |
                                                         |
// RSCS                                                  |
                                                         |
read_unlock() {                                          |
  smp_mb();                                              |
                              idx++;  // P               |
                              smp_mb();                  |
                           }                             |
                                                         |
                           scan_readers_idx(0) {         |
                               count all unlock[0];      |
                                   |                     |
                                   |                     |
  unlock[0]++; //X <--not-counted--`-----,               |
                                         |               |
}                                        V               `------,
                               // Will make sure next scan      |
                               // will not miss this unlock (X) |
                               // if other side saw flip (P) ,--`
                               // Call this MB [1]           |
                               // Order write(idx) with      |
                               // next scan's unlock.        |
                               smp_mb();                 ,---`
read_lock() {                                            |
  READ(idx)=0;                                           |
  lock[0]++; ----------------> count all lock[0];        |
  smp_mb();         |     }                              |
}     |             |                                    V
      |             `---> // Incorrect contribution to lock counting
      |                   // upto a maximum of 2 times.
      |
       `---> // Pairs with MB [1]. Makes sure that
             // the next read_lock()'s' idx read (Y) is ordered
             // with above write to unlock[0] (X).
                            |
rcu_read_unlock() {         |
  smp_mb(); <---------------`
  unlock[0]++; 
}

read_lock() {
  READ(idx) = 1; //Y
  lock[1]++;
  ...
}
                           scan_readers_idx(0) {
                               count all unlock[0]; //Q
                               ...
                          }

This makes it similar to the store buffer pattern. Using X, Y, P and Q
annotated above, we get:

READER                    UPDATER
X (write)                 P (write)

smp_mb();                 smp_mb();

Y (read)                  Q (read)


thanks,

 - Joel


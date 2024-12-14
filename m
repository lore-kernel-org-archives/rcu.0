Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523A38DE0;
	Sat, 14 Dec 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734193243; cv=none; b=drzKfiJVxQ6xPHRSZmYwrtzGMFbAMwZN/mS/RnxeH33rLC+wknuiWpJpX8Qv1XxT08/FojNvnm4Hbg2cfiKhilNNZKsx3JqNuUG+QKDCIsFwtmDrqpL4GKhCOHkRQjqwCJBfah4B0L8M8bnXJ2tukftSYSuav5A6XUbuvq9rcqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734193243; c=relaxed/simple;
	bh=xFOY7oPQThqx7H5BPU24Hoj+P6DWs3tVf+gjHwqMngY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhLrnzjJMpHksF+Hiw86N3yhProgjP1Q3aqOKwiFmFfoC3G/dXdr30bpcxkdrvKwkqqL/994yKW+XVDycXIz711cyc+LPicRfW/p+pS3kyFK3vYHnOtGGc5yaDevGCoTwYbzgxqcuNcJeVLCK+u0SpY14jqjfFg6qzClbKx+P3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjVNw0Lb; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjVNw0Lb"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so2874430e87.3;
        Sat, 14 Dec 2024 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734193240; x=1734798040; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7hsqqVu1yPkjFZNg3V8KzBFgywcNOmPcFpwTDnim7KM=;
        b=gjVNw0Lb825aHNSfBPghYBSbSnBdox1unWnZKH0glsmF3XRsdMb3QiD2mXh4f4t1ji
         zfQ9BdVxIDzpuhY9ET1DuxLWvSPidBcazL9XnVOjtZ4HhQpi3QLceLI5SpjWIWN5EyJX
         Ne5FjNzzyP+YDdYED9hRAtlZnLdjIC2EeYJgCK76OIU6IeVoKsM+SqI5/RPDfttarBtg
         jVBX/S2p1Y8s9X4KEZ2nI2b5QqnkyL8O5/JIjxKLQhBnVevBhsUQ9tvBwnF7wn2Qlq3Z
         SfSZYoV52reEFHArFAP+9N3XCKAw61A4xbzgzpQLWOIfsgSIR5/KXPkFcnEJQR/HP1T1
         /wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734193240; x=1734798040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hsqqVu1yPkjFZNg3V8KzBFgywcNOmPcFpwTDnim7KM=;
        b=go9KOxkuykdFRHMnB9sfAzWesYPMNxqBtftgLLNhl5DHZ7RB53T1p8V2s/tw43P2T0
         EHn8+qncN+W9dJkpcIjNCBuE20ZTiefFh05Jmrtl4fSuZe79sbXC4zhvdUlGxfzAUZ17
         RBUuU57Gpfelqa1WBzaZCbW0GNk9g0StQhR2IO3MEv7JPsdT3JJHO6S8OqWIqCYlwreW
         toBPj9Qr2szE+CTf1ZxlFVTLZPBVFwA5uWvRHGLYKowEkSTookldEhTpjjtDiBD6kXVh
         q7dhImt2Eu2Vnzb8azFBbQQN/OBnyH0VFjRoSau5tWWZBcstM4XkOHIdRClxenaBKGXq
         6yIw==
X-Forwarded-Encrypted: i=1; AJvYcCWniHe6FPKNuPz1BCc3wpDUItZdQRrFQHTHJvxH6ThTg22fpaV/fj0uSjN7rsuV5XdrHkXEPHLd5wf8LJ8=@vger.kernel.org, AJvYcCXaqNWu06ZN5SH8Y/7i+jZXIOYj6zcXfijGmB6Az84RoNfs6R/xLW3nodLEJOwm41wrKBGc@vger.kernel.org
X-Gm-Message-State: AOJu0YzesQ9IdD00wNNuadgiknudPQvCIw7rxqXxGH7srUV2/aWXxXEO
	SJe3k1CeUl0Gra0b8lgWwsDfTTjuBL/r2FxjXkraj96zRiDbjkwx
X-Gm-Gg: ASbGncsWMHpZ5tWxf7K9IAJmnzTI2H4+uMGoysQaBcambBpDAzFvQOs3K15yGdjMfGE
	M7SQr7sslfW5m6xrjGVdgBXu8WXATGqKebiajli3NC1chdtPMb7FK/PjgUvZuJ0kMuiYNG8OW5u
	l+MWIhBX9HiAAwfG2F9fkYynw6jGVe3Z6IcAeGqyIqfl1upUD1Ey5qmP8TmiNFqSIcMBKkdPYf7
	2xtHJ5d+VQ1cN5UGKPFLWLD7YMzOnoCj5+nDL578dmvQEa8bMIj
X-Google-Smtp-Source: AGHT+IG8vSqfLJhKILcurhIg2H5pwRILBKcBcNOpJTqFIX6TcsJ5jWUlePTR2xWzDontLNi8u2qdUQ==
X-Received: by 2002:a05:6512:401b:b0:540:c349:a80f with SMTP id 2adb3069b0e04-540c349a86cmr2191946e87.38.1734193239541;
        Sat, 14 Dec 2024 08:20:39 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9e02sm258157e87.100.2024.12.14.08.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 08:20:38 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Sat, 14 Dec 2024 17:20:37 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, urezki@gmail.com
Subject: Re: [PATCH rcu 1/2] rcu/nocb: Use switch/case on NOCB timer state
 machine
Message-ID: <Z12wVQjxqlZJuP0K@pc638.lan>
References: <c0daba35-f647-40cd-b556-3a04e03da93c@paulmck-laptop>
 <20241212184214.2018411-1-paulmck@kernel.org>
 <Z1y-egJlaH9IWKsV@pavilion.home>
 <0d069012-ab5f-4126-89b4-5f2c186b18ae@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d069012-ab5f-4126-89b4-5f2c186b18ae@paulmck-laptop>

On Fri, Dec 13, 2024 at 03:29:16PM -0800, Paul E. McKenney wrote:
> On Sat, Dec 14, 2024 at 12:08:42AM +0100, Frederic Weisbecker wrote:
> > Le Thu, Dec 12, 2024 at 10:42:13AM -0800, Paul E. McKenney a écrit :
> > > From: Frederic Weisbecker <frederic@kernel.org>
> > > 
> > > It's more convenient to benefit from the fallthrough feature of
> > > switch / case to handle the timer state machine. Also a new state is
> > > about to be added that will take advantage of it.
> > > 
> > > No intended functional change.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > Please drop this one too. It introduced a subtle (yet desired) behaviour
> > change as Boqun noted. I'll resend a better version.
> 
> I will drop both on my next rebase.  Uladzislau, over to you!
> 
Thank you. Dropped both.

--
Uladzislau Rezki

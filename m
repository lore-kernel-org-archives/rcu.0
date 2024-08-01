Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F225D101EE
	for <rcu@vger.kernel.org>; Thu,  1 Aug 2024 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722551324; cv=none; b=TSpcArzbQxdAg/CZccEQvD05wd66MJss/Oro0BoxD1jAp5e04B7KmVRhol19sxnWzIWAvy8pWytc4u17B6jrJFF+FZ9ixxjiuDyMDbzbg9uBlK6OFZ1mcIAbMRLyEreuq94vnw/zQE2fpFKg6pUybZcDd3Aq5FBnb6eqDp135o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722551324; c=relaxed/simple;
	bh=cD+DdAn/DPHyEPshk6ipvfRDDw+LFLhg5xkAt5HpHs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbyBdiCtVSSiFm4GOUywwUPCVl25/DkX72EaCY799iqInhsD+glMn+R3xzUv9ZsWXlpuX2btYBANvlG5b6vGgIIt0oOEfvwUursdY+57WCZumzBeeue1mk5ap4/+3dCEnjnlhpXfc/LbKi7BcyLypPa1uuVsTPqK8rZszTYjHl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=LFIKMjtP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="LFIKMjtP"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc47abc040so52094545ad.0
        for <rcu@vger.kernel.org>; Thu, 01 Aug 2024 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722551322; x=1723156122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRYsGq2oNdjeIvoc5FsVQQM4eH9uksp2HnfPLkPQWTM=;
        b=LFIKMjtPHzC8qUAuVDrdF4JPihti2inuKp8MtfcIZ89rMiH9drby4WLlbWqMLInTfI
         G7HkKvXKUS0j9ZznksoSmm29LJcysMu8ojfbF9ecWR80LOf7fBzS0gY0qRRdtc99t6YX
         z0f0neij1C6HeZLZ7yZaspHxuC2NJXXNsFirEXbwvAR/Elorxoer/zGVjVBXiEBcAI4e
         dA2rrQZPTMeh8z1xg842jghlPzhNgCP1VkFQpveLjKvrcbTnWhoWejlpMspFeSSm49eF
         FA/8HbUleoTZQyHNNRYYDVgniSb8uHlmfF5FY47sz4ek4dDd5sMci1x9wHe6yEQrSrmC
         5hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722551322; x=1723156122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRYsGq2oNdjeIvoc5FsVQQM4eH9uksp2HnfPLkPQWTM=;
        b=jCSbZ9vHvULT9eizKE/mhYfumzsBxOSlAwIqftd2pN1FPOnDBwxOlPsyo63ta5N14s
         fN9TQ/b+iFdPVh+6M7zUkhWKrsaLQIxqaIGdTFRSc7jc/7rQpBgprnuVcLG8MOiqRxjs
         aXMOAx4/2jfDlIvgCvZVFvpjSI02pZXNkerNxEQttdTP5tSPxNFtB0ul4rs4s/XZGbv9
         A6+Xx9obfxbsfziEFIBAM9yqQnSuwtwelItccXgXynw6BJ2HZ8vRaHU+XlCFDWWxTybN
         FgzKpqcta1dudyicvM4kr5+9wcS6kGZlL2R9ECGqagpMXzgFhnlTbIVYDgiptA5EcMSA
         c/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXEswu6K3VF1VwonrNg5kyBXp/GljDoqCe3p7WUUOHikZuGwuyAD6bGCBAqW4MfwSegdM3W99yDl5DTRBo8GWQGSvse
X-Gm-Message-State: AOJu0YxKYPr6/MYCNsmsgE9G+C9yW3WuC8m8JVpD/uIpPjrgmEvOIrMN
	hZiALvZp/h/LA0nWThvb8zqA2i6yqsDYIqxgiqleVqDX36XhzC4lBeJoBYeUY2U=
X-Google-Smtp-Source: AGHT+IG1VyhF7PulV5hUfA0sl/95gL1I+laFS95TuUeXZwqOhTGd3EUHP2S1u9L3VUz7PeMN4aTczg==
X-Received: by 2002:a17:903:41c3:b0:1f8:44f8:a364 with SMTP id d9443c01a7336-1ff5743b598mr19821295ad.48.1722551322289;
        Thu, 01 Aug 2024 15:28:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29f52sm4084735ad.32.2024.08.01.15.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 15:28:41 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sZeHm-001yL8-31;
	Fri, 02 Aug 2024 08:28:38 +1000
Date: Fri, 2 Aug 2024 08:28:38 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	syzbot <syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com>,
	Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>,
	paulmck@kernel.org, Hillf Danton <hdanton@sina.com>,
	rcu@vger.kernel.org, frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	Ted Tso <tytso@mit.edu>
Subject: Re: [syzbot] [f2fs?] WARNING in rcu_sync_dtor
Message-ID: <ZqwMFjz7TYgV+hbo@dread.disaster.area>
References: <0000000000004ff2dc061e281637@google.com>
 <20240729-himbeeren-funknetz-96e62f9c7aee@brauner>
 <20240729132721.hxih6ehigadqf7wx@quack3>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729132721.hxih6ehigadqf7wx@quack3>

On Mon, Jul 29, 2024 at 03:27:21PM +0200, Jan Kara wrote:
> Also as the "filesystem shutdown" is spreading across multiple filesystems,
> I'm playing with the idea that maybe we could lift a flag like this to VFS
> so that we can check it in VFS paths and abort some operations early. 

I've been thinking the same thing since I saw what CIFS was doing a
couple of days ago with shutdowns. It's basically just stopping all
new incoming modification operations if the flag is set. i.e. it's
just a check in each filesystem method, and I suspect that many
other filesystems that support shutdown do the same thing.

It looks like exactly the same implementation as CIFS is about to be
added to exfat - stop all the incoming methods and check in the
writeback method - so having a generic superblock flag and generic
checks before calling into filesystem methods would make it real
easy for all filesystems to have basic ->shutdown support for when
block devices go away suddenly.

I also think that we should be lifting *IOC_SHUTDOWN to the VFS -
the same ioctl is now implemented in 4-5 filesystems and they
largely do the same thing - just set a bit in the internal
filesystem superblock flags. Yes, filesystems like XFS and ext4 do
special stuff with journals, but the generic VFS implemenation could
call the filesystem ->shutdown method to do that....

> But
> so far I'm not convinced the gain is worth the need to iron out various
> subtle semantical differences of "shutdown" among filesystems.

I don't think we need to change how any filesystem behaves when it
is shut down. As long as filesystems follow at least the "no new
modifications when shutdown" behaviour, filesystems can implement
internal shutdown however they want...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
